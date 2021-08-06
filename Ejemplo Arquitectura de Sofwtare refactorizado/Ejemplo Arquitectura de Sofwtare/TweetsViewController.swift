//
//  ViewController.swift
//  Ejemplo Arquitectura de Sofwtare
//
//  Created by danielapps on 22/07/21.
//

import UIKit

class TweetsViewController: UIViewController {
    
    
    var tweetsTimeline : [UITweet] = []
    
    @IBOutlet weak var tweetsTableView: UITableView!
    @IBOutlet weak var searchUserTextField: UITextField!
    let presenter:TweetsPresenter = TweetsPresenter.instance
    override func viewDidLoad() {
        tweetsTableView.dataSource = self
        tweetsTableView.register(UINib(nibName: "TweetsTableViewCell" , bundle: nil), forCellReuseIdentifier: TweetsTableViewCell.cellIdentifier)
        
        
    }
    
    @IBAction func didPressGetLastTweets(_ sender: UIButton) {
        if let  searchedName = searchUserTextField.text, searchedName != "" {
            let userName = searchedName.replacingOccurrences(of: " ", with: "")
//            getUserLastTweets(userName: userName)
            presenter.getUserLastTweets(userName: userName, onCompletion:{ uiTweets in
                self.tweetsTimeline = uiTweets
                self.tweetsTableView.reloadData()
                self.tweetsTableView.rowHeight = UITableView.automaticDimension
                
            }, onError:{error in })
            
            
        }
        searchUserTextField.text = ""
    }
}
extension TweetsViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsTimeline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetsTableViewCell.cellIdentifier, for: indexPath) as! TweetsTableViewCell
        let tweet = tweetsTimeline[indexPath.row]
        cell.setUITweet(tweet)
        return cell
     }
}
