//
//  AnalyticsDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/30/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol AnalyticsDataDelegate {
    func received(analytics: [Analytic])
    func received(error: Error)
}

class AnalyticsDataStore {
    var delegate: AnalyticsDataDelegate?
    
    init(delegate: AnalyticsDataDelegate) {
        self.delegate = delegate
    }
    
    func loadAnalytics() {
        PFCloud.callFunction(inBackground: "getAnalyticCounts", withParameters: [:], block: {
            (results: Any?, error: Error?) -> Void in
            if let analyticsDictionary = results as? [[String : Int]] {
                let analytics = self.parse(analyticsDictionary)
                let sortedAnalytics = self.sort(analytics)
                self.delegate?.received(analytics: sortedAnalytics)
            } else if let error = error {
                self.delegate?.received(error: error)
            }
        })
    }
    
    private func parse(_ analyticsDictionary: [[String : Int]]) -> [Analytic] {
        var analytics: [Analytic] = []
        for element in analyticsDictionary {
            if let title = element.keys.first, let count = element[title], let analyticTitle = AnalyticTitle(rawValue: title) {
                let analytic = Analytic(title: analyticTitle, count: count)
                analytics.append(analytic)
            }
        }
        
        return analytics
    }
    
    private func sort(_ analytics: [Analytic]) -> [Analytic] {
        return analytics.sorted(by: { (current: Analytic, next: Analytic) -> Bool in
            let currentIndex: Int = AnalyticTitle.all.index(of: current.title) ?? 0
            let nextIndex: Int = AnalyticTitle.all.index(of: next.title) ?? 0
            return nextIndex > currentIndex
        })
    }
}
