//
//  ScreenshotViewCell.swift
//  FreeGames-IOS
//
//  Created by Mananas on 24/11/25.
//

import UIKit

class ScreenshotViewCell: UICollectionViewCell {
    
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    func render(url: String) {
        screenshotImageView.loadFrom(url: url)
    }
}
