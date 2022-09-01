//
//  PlayList.swift
//  Ted Talk
//
//  Created by Angela Lee on 26/08/2022.
//

import UIKit

class PlayListCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descrip: UILabel!
    
    func ShowPlaylistInformation(_ recived: TedTalksCellModel) {
        title.text = recived.title
        descrip.text = recived.description
    }
    
}
