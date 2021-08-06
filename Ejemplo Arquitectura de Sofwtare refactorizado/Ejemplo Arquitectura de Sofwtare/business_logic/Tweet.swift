//
//  Tweet.swift
//  Ejemplo Arquitectura de Sofwtare
//
//  Created by danielapps on 24/07/21.
//

import Foundation

struct Tweet : Decodable {
    let text : String
    let entities : TextEntities?
    let user : UserInfo
    let retweet_count : Int
    let favorite_count: Int
    
}

struct UserInfo : Decodable {
    let name : String
    let profile_image_url_https : String
}

struct TextEntities : Decodable {
    let hashtags : [HashtagsInfo]?
}

struct HashtagsInfo : Decodable {
    let text : String?
    let indices : [Int]?
}
