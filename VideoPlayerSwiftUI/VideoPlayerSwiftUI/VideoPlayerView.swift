//
//  VideoPlayerView.swift
//  VideoPlayerSwiftUI
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import SwiftUI

struct VideoPlayerView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            PlayerView()
                .overlay(Color.black.opacity(0.4))
                .blur(radius: 1)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image(systemName: "paperplane.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .padding(.bottom, 30)
                
                Text("Explore Kigali City")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Discover the most amazing places in our City and Share your experience with the No. 1 tourism community.")
                    .foregroundColor(.white)
                    .frame(maxWidth: 350)
                    .padding(.top, 20)
                    .padding(.bottom, 50)
                    .font(.system(size: 20))
                    .padding(.horizontal)
                Spacer()
                Rectangle()
                .frame(height: 1)
                .foregroundColor(.white)
                
                HStack {
                    Spacer()
                    Text("Login")
                        .padding()
                    Spacer()
                    Text("Signup")
                        .padding()
                    Spacer()
                }
            }
            
            .foregroundColor(.white)
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}
