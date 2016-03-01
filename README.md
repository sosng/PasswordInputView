# PasswordInputView
A simple password input view in swift

# Usage

1. Add a new UIView in StoryBoard or XIB file.
2. Modify the custom class to `PasswordInputView `  
3. Get the input words in closure `inputClosure: ((inputPassword: String?) -> ())?`

```swift
passwordView.inputClosure = {(inputWords: String?) -> Void in
    print(inputWords!)
}

```

#TODO

[]@IBInspectable for properties
