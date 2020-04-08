//
//  ReadNewsDetailViewController.swift
//  HaberlerComApp
//
//  Created by Mehmet Baran on 5.04.2020.
//  Copyright © 2020 Mehmet Baran. All rights reserved.
//

import UIKit
import SDWebImage
import MediaPlayer
import AVFoundation
import AVKit
import MBVideoPlayer

class ReadNewsDetailViewController: UIViewController {
    
    //Mark: Variables
    var selectedNews : NewsModal?
    
     //Mark: IBActions
    @IBAction func closeViewAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //Mark: IBOutlets
    @IBOutlet weak var newsVideo: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSpot: UILabel!
 
    //Mark: Statements
    
     //Mark: Statements
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let selectedNews = selectedNews{
                
                newsTitle.text = selectedNews.title
                newsSpot.text = selectedNews.spot
            }
            
            let playerView = MBVideoPlayerView(configuration: nil, theme: nil, header: nil)
            let playerItems = [
                PlayerItem(title: selectedNews!.title, url: selectedNews!.videoUrl, thumbnail: "")]
            
            if let currentItem = playerItems.first {
                playerView.setPlayList(currentItem: currentItem, items: playerItems, fullScreenView: view)
            }
            
            view.addSubview(playerView)
            playerView.pinEdges(to: newsVideo )
        }
    }
