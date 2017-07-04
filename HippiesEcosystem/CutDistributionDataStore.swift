//
//  CutDistributionDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 7/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

protocol CutDistributionDataDelegate {
    func received(distributions: [CutDistribution])
    func received(error: Error)
}

class CutDistributionDataStore {
    var delegate: CutDistributionDataDelegate?
    
    init(delegate: CutDistributionDataDelegate) {
        self.delegate = delegate
    }
    
    func loadDistributions() {
        PFCloud.callFunction(inBackground: "getCutDistributions", withParameters: [ : ], block: {
            (results: Any?, error: Error?) -> Void in
            if let results = results as? [FabricParse : Int] {
                let distributions = self.parse(results)
                self.delegate?.received(distributions: distributions)
            } else if let error = error {
                self.delegate?.received(error: error)
            }
        })
    }
    
    private func parse(_ results: [FabricParse : Int]) -> [CutDistribution] {
        var cutDistributions: [CutDistribution] = []
        for (fabric, count) in results {
            let cutDistribution = CutDistribution(fabric: fabric, count: count)
            cutDistributions.append(cutDistribution)
        }
        let sortedCutDistributions = sort(cutDistributions)
        return sortedCutDistributions
    }
    
    private func sort(_ cutDistributions: [CutDistribution]) -> [CutDistribution] {
        let sortedDistributions = cutDistributions.sorted { (current: CutDistribution, next: CutDistribution) -> Bool in
            return next.count > current.count
        }
        return sortedDistributions
    }
}

extension CutDistributionDataStore {
    func createCutList(from cutDistribution: CutDistribution) {
        PFCloud.callFunction(inBackground: "getOneColorCutList", withParameters: ["color" : cutDistribution.color], block: {
            (results: Any?, error: Error?) -> Void in
            if let _ = results {
                SCLAlertView().showSuccess("Success", subTitle: "Successfuly sent the color cut list to the google sheet")
            } else if let error = error {
                SCLAlertView().showError("Error", subTitle: error.localizedDescription)
            }
        })
    }
}
