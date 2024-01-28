//
//  NewsViewCell.swift
//  NewsApp-2
//
//  Created by Fatih on 28.01.2024.
//

import UIKit
import SDWebImage



protocol NewsViewCellDelegate: AnyObject {
    func openNewsURLTapped(url: String?)
}

class NewsViewCell: UICollectionViewCell {
    static let identifier = "NewsViewCell"
    
    @IBOutlet weak var newsİmageView: UIImageView!
    @IBOutlet weak var newsOvner: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsPulishAt: UILabel!
    @IBOutlet weak var webButton: UIButton!
    var article: Article?
    
    var delegate: NewsViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    @IBAction func openNewsUrl(_ sender: UIButton) {
        delegate?.openNewsURLTapped(url: article?.url)

    }
    
    func configure(data: Article?) {
        self.article = data
        newsTitle.text = data?.title
        newsDescription.text = data?.description
        newsPulishAt.text = data?.publishedAt
        newsOvner.text = data?.source?.id
        newsİmageView.sd_setImage(with: URL(string: data?.urlToImage ?? ""))
        
    }
    

}
