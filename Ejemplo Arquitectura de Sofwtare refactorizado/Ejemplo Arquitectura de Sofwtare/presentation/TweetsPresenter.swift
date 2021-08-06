//
//  TweetsPresenter.swift
//  Ejemplo Arquitectura de Sofwtare
//
//  Created by danielapps on 30/07/21.
//

import Foundation

typealias CallbackBlock<T:Any> = (_ value:[T])->Void
typealias ErrorBlock = (_ error:Error)->Void
let converter:TweetUIConverter = TweetUIConverter()
class TweetsPresenter{
    
    static let instance:TweetsPresenter = TweetsPresenter()
    let dataService:TweetsDataService = TweetsDataService.instance
    
    func getUserLastTweets(userName:String, onCompletion:@escaping CallbackBlock<UITweet>,onError:ErrorBlock?){
        
        dataService.getTweets(userName:userName, onCompletion:{ tweets in
            onCompletion(converter.convert(tweets))
        }, onError:onError)
        
        
        
    }
    
    
}
