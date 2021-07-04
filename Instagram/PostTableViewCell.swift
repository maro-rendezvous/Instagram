//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 落合克彦 on 2021/06/19.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var addCommentButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        if !postData.comments.isEmpty {
//            self.captionLabel.text! +=
            postData.comments.forEach {
                self.captionLabel.text = self.captionLabel.text! + "\n" + $0
            }

        }
        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
            self.dateLabel.font = UIFont.systemFont(ofSize: 12.0)
        }
        
        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        addCommentButton.setTitle("コメントを追加", for: .normal)
        addCommentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        addCommentButton.sizeToFit()
        commentTextField.placeholder = "コメントを追加"
        commentTextField.isHidden = true
        postButton.setTitle("投稿する", for: .normal)
        postButton.isHidden = true
    }
    
    @IBAction func addComment(_ sender: Any) {
        commentTextField.isHidden = false
        postButton.isHidden = false
        commentTextField.text = ""
    }
    
}
