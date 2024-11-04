//
//  ProfilePageVM.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 06/02/24.
//

import Foundation
import UIKit

class ProfilePageVM: ObservableObject {
     func openTelegramApp(_ userName: String){
        if let telegramURL = URL(string: "https://t.me/\(userName)") {
            if UIApplication.shared.canOpenURL(telegramURL) {
                UIApplication.shared.open(telegramURL, options: [:], completionHandler: nil)
            } else {
                print("Telegram app is not installed, handle accordingly")
            }
        } else {
            print("Invalid URL, handle accordingly")
        }
    }
    
     func openPhoneCall(_ phoneNumber: String){
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                print("Call is not installed, handle accordingly")
            }
        } else {
            print("Invalid URL, handle accordingly")
        }
    }
}
