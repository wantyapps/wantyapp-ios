//
//  ResoponseViewController.swift
//  wantyapp
//
//  Created by Uri Arev on 29/05/2021.
//

import Foundation
import UIKit

class ResponseViewController: UIViewController {
    var string: String!
    
    convenience init(_ string: String) {
        self.init(nibName: "ResponseViewController", bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var successLabel: UILabel!
        successLabel.text = string
        view.addSubview(successLabel)
        
//        view.addSubview(blackSquare)
        
    }
}

