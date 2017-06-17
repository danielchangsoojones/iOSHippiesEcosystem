//
//  Address.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Address {
    var fullName: String {
        get {
            return addressParse.firstName + " " + addressParse.lastName
        }
    }
    var phoneNumber: String {
        get {
            return addressParse.phone
        }
    }
    var street: String {
        get {
            if let addressTwo = addressParse.addressTwo {
                return addressParse.addressOne + "\n" + addressTwo
            }
            
            return addressParse.addressOne
        }
    }
    var city: String {
        get {
            return addressParse.city
        }
    }
    var state: String {
        get {
            return addressParse.state
        }
    }
    var country: String {
        get {
            return addressParse.country
        }
    }
    var zip: String {
        get {
            return addressParse.zip
        }
    }
    
    var addressParse: AddressParse!
    
    init(addressParse: AddressParse) {
        self.addressParse = addressParse
    }
    
    func toString() -> String {
        let nameLine = fullName
        let streetLine = street
        let regionLine = city + ", " + state + ", " + zip
        let countryLine = country
        let address = nameLine + "\n" + streetLine + "\n" + regionLine + "\n" + countryLine
        return address
    }
}
