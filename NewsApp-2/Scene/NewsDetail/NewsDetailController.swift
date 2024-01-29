//
//  NewsDetailController.swift
//  NewsApp-2
//
//  Created by Fatih on 28.01.2024.
//

import UIKit
import SDWebImage

class NewsDetailController: UIViewController {  
    var article: Article?
    @IBOutlet weak var newsWriter: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsYear: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        congfigure()
    }

    func congfigure() {
        if let data = article {
            self.article = data
            newsWriter?.text = data.author
            newsTitle?.text = data.title
            newsYear?.text = data.publishedAt
            newsDescription?.text = data.content
            newsImageView?.sd_setImage(with: URL(string: data.urlToImage ?? ""))
        } else {
          print("hata")
        }

    }
   

}
