//
//  LocalNotification.swift
//  
//
//  Created by Cédric Bahirwe on 15/02/2021.
//

import Foundation
import UIKit
import UserNotifications


let TITLES = "ARRAY"
let SUBTITLES = "SUBTITLES"
let BODIES = "BODIES"
let BADGESCOUNT = "BADGESCOUNT"


class Session {
    private init() {}
    static let shared = Session()
    let userDefaults = UserDefaults.standard
    
    // MARK:- Properties
    
    
    // When the current access token expires, provided by token auth authority
    var notificationTitles: [String] {
        get {
            return userDefaults.stringArray(forKey: "\(TITLES)") ?? []
        }
        set {
            userDefaults.set(newValue, forKey: "\(TITLES)")
        }
    }
    var notificationSubtitles: [String] {
        get {
            return userDefaults.stringArray(forKey: "\(SUBTITLES)") ?? []
        }
        set {
            userDefaults.set(newValue, forKey: "\(SUBTITLES)")
        }
    }
    
    var notificationsBodies: [String] {
        get {
            return userDefaults.stringArray(forKey: "\(BODIES)") ?? []
        }
        set {
            userDefaults.set(newValue, forKey: "\(BODIES)")
        }
    }
    
    var badgesNumber :Int {
        get {
            return userDefaults.integer(forKey: "\(BADGESCOUNT)")
        }
        set (newValue) {
            userDefaults.set(newValue, forKey: "\(BADGESCOUNT)")
        }
    }
    
    // This method is used to destroy a session
    func destroy() {
        UserDefaults.standard.removeObject(forKey: TITLES)
        UserDefaults.standard.removeObject(forKey: SUBTITLES)
        UserDefaults.standard.removeObject(forKey: BODIES)
        UserDefaults.standard.removeObject(forKey: BADGESCOUNT)
    }
    
}


class LocalNotification {
    let notificationTitles = Session.shared.notificationTitles
    let notificationSubtitles = Session.shared.notificationSubtitles
    let notificationsBodies = Session.shared.notificationSubtitles
    
    
    
    private init() {
        Session.shared.notificationTitles = ["alpha", "beta", "cedte", "afasf", "asrar"]
        Session.shared.notificationSubtitles = ["giga", "tera", "peta", "micro", "yota"]
        Session.shared.notificationsBodies = ["fingdugiubgiuaga", "qgogniounaosiugnoiusngio", "asdungonoinasdgonsdog", "indsgoasodngosndgiosdiuandg", "asrar"]
        print(Session.shared.badgesNumber)
    }
    
    func createNotificaton() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound]) { (success, error) in
            if success {
                print("Authorization Granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        let content = UNMutableNotificationContent()
        content.title  = Session.shared.notificationTitles[Session.shared.badgesNumber]
        //        content.subtitle =  Session.shared.notificationSubtitles[Session.shared.badgesNumber]
        content.body = Session.shared.notificationsBodies[Session.shared.badgesNumber]
        content.sound = UNNotificationSound.default
        //
        let imageName = "applelogo"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
        let attachement = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        
        let date =  Date().addingTimeInterval(5)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        content.attachments = [attachement]
        
        Session.shared.badgesNumber += 1
        
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
