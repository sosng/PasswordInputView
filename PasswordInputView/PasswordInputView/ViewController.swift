//
//  ViewController.swift
//  PasswordInputView
//
//  Created by Sayaka on 16/2/27.
//  Copyright © 2016年 swift.moe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordView: PasswordView!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordView.inputClosure = {(inputWords: String?) -> Void in
            print(inputWords!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

