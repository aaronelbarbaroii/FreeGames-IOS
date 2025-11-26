//
//  DetailViewController.swift
//  FreeGames-IOS
//
//  Created by Mananas on 17/11/25.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    
    
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // screenshotsCollectionView.dataSource = self
        
        navigationItem.title = game.title
        
        getGameById()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return game.screenshots?.count ?? 0
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = screenshotsCollectionView.dequeueReusableCell(withReuseIdentifier: "Screenshot Cell", for: indexPath) as! ScreenshotViewCell
        cell.render(url: game.screenshots![indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let screenshot = game.screenshots![indexPath.row]
           thumbnailImageView.loadFrom(url: screenshot.image)
       }
    
    
    func loadData(){
        thumbnailImageView.loadFrom(url: game.thumbnail)
        
        titleLabel.text = game.title
        descriptionLabel.text = game.description
        
        genreLabel.text = game.genre
        
        
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
        
        let screenshot = Screenshot(image: game.thumbnail)
        game.screenshots?.insert(screenshot, at: 0)
        
        screenshotsCollectionView.reloadData()
        
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
    
    @IBAction func shareContent(_ sender: Any) {
        let text = "Check out this game: \(game.title) - \(game.profileUrl)"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func playNow(_ sender: Any) {
            if let url = URL(string: game.gameUrl) {
                UIApplication.shared.open(url)
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
