//
//  TweetsDataService.swift
//  Ejemplo Arquitectura de Sofwtare
//
//  Created by danielapps on 31/07/21.
//

import Foundation

class TweetsDataService{
    static let instance:TweetsDataService = TweetsDataService()
    let twitterApiToken = "AAAAAAAAAAAAAAAAAAAAAJDLRwEAAAAA6FX%2BT5SlbziSI8GwRUEzKw8tH7k%3DMGE4SPLWvW8nBoIY4uT6Iu6JiXBVw8XLQFN2LieuToEi0w4FJp"
    
    // dataService.getTweets(username:userName, onCompletion:{ tweets in }, onError:{error in })
    func getTweets(userName:String, onCompletion:@escaping CallbackBlock<Tweet>,onError:ErrorBlock?){
        
        let url = URL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?exclude_replies=true&screen_name=\(userName)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(twitterApiToken)", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let decodeData : [Tweet] = try JSONDecoder().decode([Tweet].self, from: data)
                DispatchQueue.main.async {
//                    self.tweetsTimeline = decodeData
//                    self.tweetsTableView.reloadData()
                    onCompletion(decodeData)
                }
            }catch{
                print("############\(error)")
                onError?(error)
            }
        }
        task.resume()
        
        
    }
}
