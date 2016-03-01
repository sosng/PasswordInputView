//
//  PasswordView.swift
//
//  Created by Sayaka on 16/2/27.
//  Copyright © 2016年 swift.moe. All rights reserved.
//

import UIKit

class PasswordView: UIView {
    
    @IBOutlet weak var indicator0: UIView!
    @IBOutlet weak var indicator1: UIView!
    @IBOutlet weak var indicator2: UIView!
    @IBOutlet weak var indicator3: UIView!
    @IBOutlet weak var indicator4: UIView!
    @IBOutlet weak var indicator5: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var line0Width: NSLayoutConstraint!
    @IBOutlet weak var line1Width: NSLayoutConstraint!
    @IBOutlet weak var line2Width: NSLayoutConstraint!
    @IBOutlet weak var line3Width: NSLayoutConstraint!
    @IBOutlet weak var line4Width: NSLayoutConstraint!

    var indicators: [UIView] = []
    var inputedWords: [String] = [] {
        didSet {
            print(inputedWords)
            updateIndocator(inputedWords.count)
            inputClosure?(inputPassword: inputedWords.joinWithSeparator(""))
        }
    }
    
    @IBOutlet weak var inputTextFiled: UITextField!
    
    var inputClosure: ((inputPassword: String?) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
        self.setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
        self.setupSubviews()
    }
    
    private func loadNib() {
        let nibView = UINib(nibName: "PasswordView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil).first as! UIView
        nibView.frame = self.bounds
        nibView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(nibView)
    }
    
    private func setupSubviews() {
        indicators = [indicator0, indicator1, indicator2, indicator3, indicator4, indicator5]
        indicators.forEach{
            $0.hidden = true
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
        }
        
        [line0Width, line1Width, line2Width, line3Width, line4Width].forEach{
            $0.constant = 1.0 / UIScreen.mainScreen().scale
        }
        
        borderView.layer.borderColor = UIColor.lightGrayColor().CGColor
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = 5
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        if inputTextFiled.isFirstResponder() {
            inputTextFiled.resignFirstResponder()
        } else {
            inputTextFiled.becomeFirstResponder()            
        }

    }
}

extension PasswordView {
    private func updateIndocator(stringLength: Int) {
        if stringLength > 6 { return }
        indicators.forEach{
            $0.hidden = true
        }
        indicators[0..<stringLength].forEach{
            $0.hidden = false
        }
    }
}

extension PasswordView: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.location >= 6 {
            return false
        }
        // delete
        if string.characters.count == 0 {
            inputedWords.removeLast()
            return true
        } else {
            inputedWords.append(string)
        }
        
        return range.location < 6
    }
}


