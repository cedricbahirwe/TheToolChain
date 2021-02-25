//
//  ContentView.swift
//  SocialMedia
//
//  Created by Cédric Bahirwe on 25/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var image: UIImage = .init()
    @State private var presentPickerSheet = false
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: UIScreen.main.bounds.size.width-50,
                        height: UIScreen.main.bounds.size.width-50
                    )
                    .background(Color.blue.opacity(0.1))
                    .clipped()
                    .cornerRadius(10)
                
                Button(action: {
                    presentPickerSheet.toggle()
                }, label: {
                    Label("Select an image", systemImage: "plus.circle.fill")
                        .foregroundColor(Color(.systemBackground))
                        .padding()
                        .background(Color(.label))
                        .cornerRadius(10)
                    
                })
                .sheet(isPresented: $presentPickerSheet) {
                    ImagePicker(image: $image)
                }
                
                
            }
            .navigationTitle("Image Sharing")
            .navigationBarItems(
                trailing:
                    Button(action: shareTapped) {
                        Image(systemName: "square.and.arrow.up")
                            .padding(8)
                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func shareTapped() {
        guard let image = image.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        //        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        //        present(vc, animated: true)
        
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true, completion: nil)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
