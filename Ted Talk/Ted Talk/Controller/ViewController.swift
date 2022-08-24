//
//  ViewController.swift
//  Ted Talk
//
//  Created by Gonzalo Perretti on 4/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tableViewData: [TedTalkData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.activityIndicator.startAnimating()
        }
        
        /*func getDataFromBackend(completionHandler: @escaping() -> Void) {
            DispatchQueue.global(qos: .background).async {
                self.tableViewData = Parse().parseTedTalk("tedTalks",tableViewData)
                DispatchQueue.main.async {
                    completionHandler()
                }
            }
        }*/
    }
}

