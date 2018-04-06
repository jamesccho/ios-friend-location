//
//  Friend.swift
//  FriendLocationSample
//
//  Created by James Chan on 4/4/2018.
//  Copyright © 2018 James Chan. All rights reserved.
//

struct Friend: Codable {
    
    var name: String
    var picture: String
    var location: Location
    
    struct Location: Codable {
        var longitude: Double
        var latitude: Double
    }
}
