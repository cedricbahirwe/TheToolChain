//
//  NotificationManager.swift
//  LocationNotification-SwiftUI
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import Foundation
import SwiftUI


class LocalNotificationManager: ObservableObject {
    var notification =  [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    func sendNotification(title: String, subtitle: String?, body: String, launchIn: Double, identifier: String) {
       let content = UNMutableNotificationContent()
       content.title = title
       if let subtitle = subtitle {
           content.subtitle = subtitle
       }
        content.body = body
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName.init("machineSound.wav"))
        
        let imageName = "moi"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "jpg") else { return }
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
