//
//  DetailViewController.swift
//  FreeGames-IOS
//
//  Created by Mananas on 17/11/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var osLabel: UILabel!
    @IBOutlet weak var processorLabel: UILabel!
    @IBOutlet weak var memoryLabel: UILabel!
    @IBOutlet weak var graphicsLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    
    
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = game.title
        
        getGameById()
    }
    
    
    func loadData(){
        thumbnailImageView.loadFrom(url: game.thumbnail)
        titleLabel.text = game.title
        genreLabel.text = game.genre
        descriptionLabel.text = game.description
        osLabel.text = game.minSystemRequirements?.os ?? "----"
        processorLabel.text = game.minSystemRequirements?.processor ?? "----"
        memoryLabel.text = game.minSystemRequirements?.memory ?? "----"
        graphicsLabel.text = game.minSystemRequirements?.graphics ?? "----"
        storageLabel.text = game.minSystemRequirements?.storage ?? "----"
        if(game.platform == "Web Browser"){
            platformImageView.image = UIImage(systemName: "globe")
        }
        else {
            platformImageView.image = UIImage(systemName: "desktopcomputer")
        }
        
    }
    
    
    @IBAction func expanDescription(_ sender: UIButton) {
        if descriptionLabel.numberOfLines == 0 {
            descriptionLabel.numberOfLines = 5
            sender.setImage(UIImage(systemName: "arrow.up.and.line.horizontal.and.arrow.down"), for: .normal)
        } else {
            descriptionLabel.numberOfLines = 0
            sender.setImage(UIImage(systemName: "arrow.down.and.line.horizontal.and.arrow.up"), for: .normal)
        }
    }
    
    func getGameById() {
        Task {
            game = await ServiceApi().getGameById(id: game.id)
            
            DispatchQueue.main.async {
                self.loadData()
            }
            
        }
    }
    
    

}
