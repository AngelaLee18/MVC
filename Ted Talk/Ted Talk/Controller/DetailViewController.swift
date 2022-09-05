//
//  DetailViewContriller.swift
//  Ted Talk
//
//  Created by Angela Lee on 02/09/2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {

    // MARK: - IBOutles
    @IBOutlet weak var titleD: UILabel!
    
    @IBOutlet weak var views: UILabel!
    var talk: DetailModel?
    
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var descriptiond: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ShowDetail()
        
        let myURL = URL(string: talk?.url ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    // MARK: - Show details function
    func ShowDetail() {
        guard let talk = talk else {
            return
        }
        titleD.text = talk.title
        views.text = "#of views: \(String(talk.view))"
        publishedDate.text = "Published date: \(String(talk.date))"
        name.text = (talk.name)
        descriptiond.text = talk.description
        for _ in talk.tags {
            tags.text = "Tags: \(talk.tags.joined(separator: ", ")) "
        }
    }
}
