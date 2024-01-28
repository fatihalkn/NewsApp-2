//
//  HeaderTabsCell.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit

class HeaderTabsCell: UICollectionViewCell {
    static let identifier = "HeaderTabsCell"
    @IBOutlet weak var headerTabsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }

}
