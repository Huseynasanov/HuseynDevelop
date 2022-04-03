//
//  SearchCollectionViewCell.swift
//  Final
//
//  Created by Huseyn Hasanov on 28.03.22.
//

import UIKit

class SearchCollectionViewCellVC: UICollectionViewCell {
    @IBOutlet weak var media: UIImageView!{
        didSet{
            media.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet weak var transparentView: UIView!{
        didSet{
            transparentView.layer.cornerRadius = 7
        }
    }
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var title: UILabel!
    
}
