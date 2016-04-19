//
//  PasswordView.swift
//
//  Created by Sayaka on 16/2/27.
//  Copyright © 2016年 swift.moe. All rights reserved.
//

import UIKit

@IBDesignable class PasswordView: UIView {
    
    @IBOutlet weak var indicator0: UIView!
    @IBOutlet weak var indicator1: UIView!
    @IBOutlet weak var indicator2: UIView!
    @IBOutlet weak var indicator3: UIView!
    @IBOutlet weak var indicator4: UIView!
    @IBOutlet weak var indicator5: UIView!
    @IBOutlet weak var line0: UIView!
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var line0Width: NSLayoutConstraint!
    @IBOutlet weak var line1Width: NSLayoutConstraint!
    @IBOutlet weak var line2Width: NSLayoutConstraint!
    @IBOutlet weak var line3Width: NSLayoutConstraint!
    @IBOutlet weak var line4Width: NSLayoutConstraint!
    @IBOutlet weak var inputTextFiled: UITextField!
    
    @IBInspectable var borderColor: UIColor = UIColor.lightGrayColor() {
        didSet {
           borderView.layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            [line0, line1, line2, line3, line4].forEach{$0.backgroundColor = lineColor}
        }
    }
    
    @IBInspectable var indicatorColor: UIColor = UIColor.blackColor() {
        didSet {
            indicators.forEach{$0.backgroundColor = indicatorColor}
        }
    }
    
    var indicators: [UIView] = []
    var inputClosure: ((inputPassword: String?) -> ())?
    var inputedWords: [String] = [] {
        didSet {
            updateIndicators(inputedWords.count)
            inputClosure?(inputPassword: inputedWords.joinWithSeparator(""))
        }
    }
    
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
        let nibView = NSBundle(forClass: self.classForCoder).loadNibNamed("PasswordView", owner: self, options: nil).first as! UIView
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
        
        borderView.layer.borderColor = self.borderColor.CGColor
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
    private func updateIndicators(stringLength: Int) {
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


