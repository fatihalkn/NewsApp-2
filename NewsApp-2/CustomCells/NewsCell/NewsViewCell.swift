//
//  NewsViewCell.swift
//  NewsApp-2
//
//  Created by Fatih on 28.01.2024.
//

import UIKit
import SDWebImage
import SwipeCellKit



protocol NewsViewCellDelegate: AnyObject {
    func openNewsURLTapped(url: String?)
}

class NewsViewCell: SwipeCollectionViewCell {
    
    static let identifier = "NewsViewCell"
    
    @IBOutlet weak var newsİmageView: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsPulishAt: UILabel!
    @IBOutlet weak var webButton: UIButton!
    var article: Article?
    
    var interface: NewsViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsİmageView.layer.cornerRadius = 16.0
        newsİmageView.clipsToBounds = true
    }
    
    @IBAction func openNewsUrl(_ sender: UIButton) {
        interface?.openNewsURLTapped(url: article?.url)

    }
    
    func configure(data: Article?) {
        self.article = data
        newsTitle.text = data?.title
        newsDescription.text = data?.description
        newsPulishAt.text = data?.publishedAt
        newsİmageView.sd_setImage(with: URL(string: data?.urlToImage ?? ""))
        
    }
    

}
