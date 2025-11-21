//
//  GameViewCell.swift
//  FreeGames-IOS
//
//  Created by Mananas on 13/11/25.
//

import UIKit

class GameViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconPlatform: UIImageView!
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        shadowView.layer.cornerRadius = 16
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 4, height: 4)
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render(game: Game) {
        titleLabel.text = game.title
        genreLabel.text = game.genre
        descriptionLabel.text = game.descriptionShort
        if(game.platform == "Web Browser"){
            iconPlatform.image = UIImage(systemName: "globe")
        }
        else {
            iconPlatform.image = UIImage(systemName: "desktopcomputer")
        }
        
        thumbnailImageView.loadFrom(url: game.thumbnail)
    }

}
