//
//  HeaderViewCell.swift
//  NewsApp-2
//
//  Created by Fatih on 27.01.2024.
//

import UIKit
import SDWebImage

class HeaderViewCell: UICollectionViewCell {
    static let identifier = "HeaderViewCell"
    @IBOutlet weak var headerNewsView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(data: Article) {
//        data.urlToImage
        headerNewsView.sd_setImage(with: URL(string: data.urlToImage ?? ""))
    }
}
