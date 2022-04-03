//
//  SearchTableViewCellVC.swift
//  Final
//
//  Created by Huseyn Hasanov on 28.03.22.
//

import UIKit

class SearchTableViewCellVC: UITableViewCell {
    @IBOutlet weak var topicLabelSearch: UILabel!
    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var media: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

  
    @IBOutlet weak var topicView: UIView!{
        didSet{
            topicView.layer.cornerRadius = 10
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        media.layer.cornerRadius = 7
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }

}
