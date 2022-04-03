//
//  InfoTableViewCellVC.swift
//  Final
//
//  Created by Huseyn Hasanov on 30.03.22.
//

import UIKit

class SaveTableViewCellVC: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        poster.layer.cornerRadius = 7
    }

 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8))
    }
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var topicView: UIView!{
        didSet{
            topicView.layer.cornerRadius = 10
        }
    }
}
