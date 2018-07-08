//
//  GeneralViewController.swift
//  VirtualTourist
//
//  Created by The book on 2018. 6. 16..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK : - show Alert function
    func showAlert(title: String, message: String, action: (()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alertAction)in
            action?()
        }))
        self.present(alert, animated: true)
    }
    
    func save() {
        do {
            try DataController.sharedInstance().saveContext()
        } catch {
            showAlert(title: "Error", message: "Error Occured: \(error) ")
        }
    }
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
}
