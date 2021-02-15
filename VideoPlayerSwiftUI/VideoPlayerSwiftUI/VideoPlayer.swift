//
//  VideoPlayer.swift
//  VideoPlayerSwiftUI
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import Foundation
import SwiftUI

struct PlayerView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVideoPlayer {
        return UIVideoPlayer()
    }

    func updateUIView(_ uiView: UIVideoPlayer, context: Context) {
        
    }
}
