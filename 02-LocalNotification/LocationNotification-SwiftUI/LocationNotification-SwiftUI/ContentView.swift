//
//  ContentView.swift
//  LocationNotification-SwiftUI
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LocalNotification()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LocalNotification: View {
    @ObservedObject var notificationManager = LocalNotificationManager()
    
    @State var showFootnote = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    withAnimation {
                        self.showFootnote.toggle()
                        self.notificationManager.sendNotification(title: "Hurray!", subtitle: nil, body: "If you see this text, launching the local notification worked!", launchIn: 5, identifier: "notificationDemo")
                        
                        self.notificationManager.sendNotification(title: "Hurray!", subtitle: nil, body: "If you see this text, launching the local notification worked!", launchIn: 10, identifier: "cedbahirw")
                    }
                }) {
                    Text("Launch Local Notification 🚀")
                        .font(.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                if showFootnote {
                    Text("Notification Arrives in 5 seconds")
                        .font(.footnote)
                }
            }
            .navigationBarTitle("Local Notification Demo", displayMode: .inline)
        }
    }
}
