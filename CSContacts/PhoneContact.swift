//
//  PhoneContact.swift
//  ContactSync
//
//  Created by Vedran on 26/03/2019.
//  Copyright © 2019 Vedran. All rights reserved.
//

import Foundation
import Contacts

public class PhoneContact {
    
    let phoneNumbers:[String]?
    let name:String?
    let serverId:String?
    let phoneIdentifier:String
    var email:String?
    
    var isFavourite = false
    
    init(phoneIdentifier: String, serverId: String, name: String, email: String?, phoneNumbers: [String]?) {
        self.phoneIdentifier = phoneIdentifier
        self.serverId = serverId
        self.name = name
        self.phoneNumbers = phoneNumbers
        self.isFavourite = true
    }
    
    convenience init?(fromUserData data: [String : Any], phoneId: String) {
        guard let id = data["_id"] as? String,
            let phoneNumber = data["phoneNumber"] as? String,
            let name = data["name"] as? String else {
                return nil
        }
        self.init(phoneIdentifier: phoneId,
                  serverId: id, name: name,
                  email: nil,
                  phoneNumbers: [phoneNumber])
    }
    
    convenience init?(contact: CNContact, data: [String : Any]) {
        guard let serverId = data["_id"] as? String,
        let phoneNumber = data["phoneNumber"] as? String else {
            return nil
        }
        
        self.init(phoneIdentifier: contact.identifier,
                  serverId: serverId,
                  name: contact.singleStringName(),
                  email: contact.emailAddresses.first?.value as String?,
                  phoneNumbers: [phoneNumber])
    }
    
    func toRealmObject() -> PhoneContactsReal {
        return PhoneContactsReal(withPhoneContact: self)
    }
    
}

extension PhoneContact: Equatable {
    public static func == (lhs: PhoneContact, rhs: PhoneContact) -> Bool {
        return lhs.phoneIdentifier == rhs.phoneIdentifier && lhs.serverId == rhs.serverId
    }
}


