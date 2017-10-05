//
//  Survey.swift
//  Survey2
//
//  Created by Laura O'Brien on 10/5/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation

struct Survey {
    
    //Keys
    private let nameKey = "name"
    private let emojiKey = "emoji"
    private let uuidKey = "uuid"

    
    //Properties
    let name: String
    let emoji: String
    let identifier: UUID

    //Memberwise
    init(name: String, emoji: String, identifier: UUID = UUID()) {
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    
    //Failable
    init?(dictionary: [String: String], identifier: String) {
     guard let name = dictionary[nameKey],
        let emoji = dictionary[emojiKey],
        let identifier = UUID(uuidString: identifier)
        else { return nil }
        
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    
    
    //Dictionary Rep
    var dictionaryRep: [String: Any]{
        
        let dictionary: [String: Any] = [
            nameKey: name,
            emojiKey: emoji,
            uuidKey: identifier.uuidString
        ]
        return dictionary
    }
    
    //Turn/serialize dictionaryRep into Data
    //REturn JSON Data from our object
    
    //PUT to JSON
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRep, options: .prettyPrinted)
    }
    
    
}

