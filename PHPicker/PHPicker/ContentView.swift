//
//  ContentView.swift
//  PHPicker
//
//  Created by Cédric Bahirwe on 24/03/2021.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var image: Image?  = Image(systemName: "photo.on.rectangle.angled")
    @State private var presentSheet: Bool = false
    @State private var phFilter: PHPickerFilter = PHPickerFilter.images
    var body: some View {
        ZStack {
            image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(.systemFill))
                .padding()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        phFilter = .images
                    }, label: {
                        Image(systemName: "photo")
                            .imageScale(.large)
                    })
                    
                    Button(action: {
                        phFilter = .livePhotos
                    }, label: {
                        Image(systemName: "livephoto")
                            .imageScale(.large)
                    })
                }
                .padding(.trailing)
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $presentSheet) {
            PhotoPicker(isPresented: $presentSheet, selectedImage: $image, phFilter: phFilter)
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
