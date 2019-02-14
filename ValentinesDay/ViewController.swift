//
//  ViewController.swift
//  ValentinesDay
//
//  Created by Michael Wakeling on 2/14/19.
//  Copyright © 2019 Michael Wakeling. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    var index: Int = 0
    let messages: [String] = ["I hope you're having a great day!", "You are one of a kind 💙", "I am so lucky to have found you", "You're perfect for me", "No one else can compare to you", "You are doing a great job!", "I can't wait to see what the future holds for us", "I find it bittersweet, because you gave me something to lose - Lukas Graham", "I may not be Dr. Avery but I know I can still take care of you 👨🏽‍⚕️", "If I had a nickel for everytime you cross my mind, I'd have $0.05 because you never leave", "Thank you for being so supportive of me! 🥰", "I could not have asked for a better person to be with", "I prayed for you", "You give me purpose", "You have a bright future ahead of you"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        if(requestUserPermission()){
            sendUserNotification()//If true
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addViews() {
        let image: UIImageView = {
            let img = UIImage(named: "logo")
            let me = UIImageView()
            me.image = img
            me.translatesAutoresizingMaskIntoConstraints = false
            return me
        }()
        let vDayMessage: UILabel = {
            let lbl = UILabel()
            lbl.text = messages[index]
            lbl.textColor = .red
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.adjustsFontSizeToFitWidth = true
            return lbl
        }()
        view.addSubview(image)
        view.addSubview(vDayMessage)
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 180).isActive = true
        image.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        vDayMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vDayMessage.bottomAnchor.constraint(equalTo: image.topAnchor, constant: 20).isActive = true
    }
    
    func requestUserPermission() -> Bool {
        var userGranted = true
        UNUserNotificationCenter.current().requestAuthorization(options:
            [[.alert, .sound, .badge]], completionHandler: { (granted, error) in
                if(!granted || error != nil){
                    userGranted = false
                }
        })
        return userGranted
    }
    func sendUserNotification() {
        let content = UNMutableNotificationContent()
        
        content.sound = UNNotificationSound.default
        content.title = "Hey Gorgeous!"
        index = Int.random(in: 0 ..< messages.count)
        content.body = messages[index]
        content.badge = 1
        
        var dateInfo = DateComponents()
        dateInfo.hour = 18
        dateInfo.minute = 50
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        let request = UNNotificationRequest(identifier: "Message", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }

}

