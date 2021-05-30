//
//  ViewController.swift
//  wantyapp
//
//  Created by Uri Arev on 27/05/2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var addressText: UITextField!
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    func changeErrorLabel(_ string: String) {
        errorLabel.text = string
        errorLabel.textAlignment = NSTextAlignment.center
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let url = URL(string: addressText.text ?? "")
        guard let requestUrl = url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue(usernameText.text, forHTTPHeaderField: "username")
        request.setValue(passwordText.text, forHTTPHeaderField: "password")
        DispatchQueue.main.async {
            self.changeErrorLabel("Loading...")
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8 ) {
                print(dataString)
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if JSONSerialization.isValidJSONObject(json as Any) == true {
                    if let success = json?["success"] {
                        print("Success: \(success)")
                        if success as? Int == 1 {
                            DispatchQueue.main.async {
                                self.changeErrorLabel("Success: true")
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.changeErrorLabel("Success: false")
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.changeErrorLabel("Server response is not valid JSON")
                    }
                }
            }
        }
        task.resume()
    }
}

