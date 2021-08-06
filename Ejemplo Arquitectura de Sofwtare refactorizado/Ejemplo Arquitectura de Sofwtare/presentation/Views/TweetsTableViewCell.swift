//
//  TweetsTableViewCell.swift
//  Ejemplo Arquitectura de Sofwtare
//
//  Created by danielapps on 23/07/21.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {
    static let cellIdentifier = "TweetsCells"
    
    @IBOutlet weak var retweetsLabel : UILabel!
    @IBOutlet weak var likesLabel : UILabel!
    @IBOutlet weak var tweetsTextContent: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetsTextContent.isUserInteractionEnabled = true
        tweetsTextContent.isEditable = false
        tweetsTextContent.isSelectable = true
        tweetsTextContent.dataDetectorTypes = UIDataDetectorTypes.link
        
    }
    func setUITweet(_ tweet:UITweet){
        tweetsTextContent.attributedText = tweet.textContent
        userProfileImage.load(urlString: tweet.imageUrl)
        likesLabel.text = tweet.likes
        retweetsLabel.text = tweet.retweets
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    func load(urlString: String){
        let url = URL(string: urlString)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
