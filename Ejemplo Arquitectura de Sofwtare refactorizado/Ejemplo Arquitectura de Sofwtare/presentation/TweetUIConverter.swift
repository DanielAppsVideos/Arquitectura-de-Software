//
//  File.swift
//  Ejemplo Arquitectura de Sofwtare
//
//  Created by danielapps on 31/07/21.
//

import Foundation
import UIKit
struct UITweet{
    let userName:String
    let imageUrl:String
    let textContent:NSAttributedString
    let likes:String
    let retweets:String
}


class TweetUIConverter{
    // converter.convert(tweets)
    func convert(_ tweets:[Tweet])->[UITweet]{
        
        return tweets.map({ tweet in
            return convertTweet(tweet)
            
            
        })
        
    }
    func convertTweet(_ tweet:Tweet)->UITweet{
        
        let userName = tweet.user.name
        let imageUrl = tweet.user.profile_image_url_https
        var text:NSAttributedString!
        let favorites = formatTweetsStats(value: tweet.favorite_count)
        let retweets = formatTweetsStats(value: tweet.retweet_count)
        if let entities = tweet.entities {
            if let hashtags = entities.hashtags {
                // cell.tweetsTextContent.attributedText =
                text = formatHashtags(text: tweet.text, hashtags: hashtags)
                
            }
        }else{
            text = formatHashtags(text: tweet.text, hashtags: [])
        }
        return UITweet(userName:userName,imageUrl:imageUrl, textContent:text,
                       likes: favorites, retweets: retweets)
    }
    private func formatTweetsStats(value: Int)->String{
        if value > 999 {
            let formatedValue = value/1000
            return "\(formatedValue)k"
        }
        
        return "\(value)"
    }
    private func formatHashtags(text: String, hashtags: [HashtagsInfo])->NSMutableAttributedString{
        let mutableAttributedString = NSMutableAttributedString(string: text)
        
        
        for hashtag in hashtags {
            if let hashtagText = hashtag.text {
                var range = (text as NSString).range(of: hashtagText)
                range.location -= 1
                range.length += 1
                mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "hashtagColor")!, range: range)
            }
        }
        return mutableAttributedString
    }
    
}
