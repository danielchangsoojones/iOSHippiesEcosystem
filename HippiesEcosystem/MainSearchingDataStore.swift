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
    func passSearchResults(results: [ProductType])
    func getMostCurrentSearchText() -> String?
}

class MainSearchingDataStore {
    var delegate: MainSearchingDelegate?
    fileprivate var isSearching = false
    
    init(delegate: MainSearchingDelegate) {
        self.delegate = delegate
    }
}

//search extension
extension MainSearchingDataStore {
    //TODO: make it search for our products
    func search(text: String) {
        if !isSearching {
            isSearching = true
            let lowercasedText = text.lowercased()
            PFCloud.callFunction(inBackground: "searchProduct", withParameters: ["searchText": lowercasedText], block: {
                (results: Any?, error: Error?) -> Void in
                if let array = results as? NSArray {
                    print(array[0])
                }
                if let productTypeParses = results as? [ProductTypeParse] {
                    let productTypes = productTypeParses.map({ (p: ProductTypeParse) -> ProductType in
                        return ProductType(p: p)
                    })
                    self.delegate?.passSearchResults(results: productTypes)
                } else if let error = error {
                    print(error)
                }
                self.compareToNewestSearch(queriedSearchText: text)
            })
        }
    }
    
    fileprivate func compareToNewestSearch(queriedSearchText: String) {
        if let newestSearchText = delegate?.getMostCurrentSearchText(), queriedSearchText != newestSearchText {
            search(text: newestSearchText)
        }
        isSearching = false
    }
}
