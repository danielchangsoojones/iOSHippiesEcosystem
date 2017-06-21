//
//  MainSearchingDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/29/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol MainSearchingDelegate {
    func passSearchResults(results: [Any])
    func getMostCurrentSearchText() -> String?
}

class MainSearchingDataStore {
    enum SearchType: String {
        case productType = "searchProduct"
        case color = "searchColor"
    }
    
    var delegate: MainSearchingDelegate?
    fileprivate var isSearching = false
    
    init(delegate: MainSearchingDelegate) {
        self.delegate = delegate
    }
    
    func querySearchResults(text: String) {
        fatalError("must override in subclasses")
    }
    
    func transform(results: Any) -> [Any] {
        return []
    }
}

//search extension
extension MainSearchingDataStore {
    func search(text: String) {
        if !isSearching {
            isSearching = true
            querySearchResults(text: text)
        }
    }
    
    func search(text: String, type: SearchType) {
        let lowercasedText = text.lowercased()
        PFCloud.callFunction(inBackground: type.rawValue, withParameters: ["searchText": lowercasedText], block: {
            (results: Any?, error: Error?) -> Void in
            if let results = results {
                let searchResults = self.transform(results: results)
                self.delegate?.passSearchResults(results: searchResults)
            } else if let error = error {
                print(error)
            }
            self.compareToNewestSearch(queriedSearchText: text)
        })
    }
    
    fileprivate func compareToNewestSearch(queriedSearchText: String) {
        if let newestSearchText = delegate?.getMostCurrentSearchText(), queriedSearchText != newestSearchText {
            search(text: newestSearchText)
        }
        isSearching = false
    }
}
