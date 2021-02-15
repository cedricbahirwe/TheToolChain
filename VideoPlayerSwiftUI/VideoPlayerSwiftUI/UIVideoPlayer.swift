//
//  UIVideoPlayer.swift
//  VideoPlayerSwiftUI
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import Foundation
import AVKit
import SwiftUI

class UIVideoPlayer: UIView {
    var playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let videoName = "video"
        guard let imageURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") else { return }
        let player = AVPlayer(url: imageURL )
        player.isMuted = true
        player.play()
        
        playerLayer.player = player
        playerLayer.videoGravity = AVLayerVideoGravity(rawValue: AVLayerVideoGravity.resizeAspectFill.rawValue)
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

