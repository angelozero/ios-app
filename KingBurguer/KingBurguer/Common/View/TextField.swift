//
//  TextField.swift
//  KingBurguer
//
//  Created by angelo on 29/10/25.
//

import UIKit

protocol TextFieldDelegate: UITextFieldDelegate {
    func textFieldDidChanged(isValid: Bool, bitmask: Int, text: String)
}


class TextField: UIView {
    
    var maskField: MaskUtil? 
    
    var text: String {
        get{
            return editTextField.text!
        }
    }
    
    var placeholder: String? {
        willSet{
            editTextField.placeholder = newValue
        }
    }
    
    var returnKeyType: UIReturnKeyType = .next {
        willSet{
            editTextField.returnKeyType = newValue
        }
    }
    
    var delegate: TextFieldDelegate? {
        willSet {
            editTextField.delegate = newValue
        }
    }
    
    override var tag: Int {
        willSet {
            super.tag = newValue
            editTextField.tag = newValue
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        willSet {
            if newValue == .emailAddress {
                editTextField.autocapitalizationType = .none
            }
            editTextField.keyboardType = newValue
        }
    }
    
    var secureTextEntry: Bool = false {
        willSet {
            editTextField.isSecureTextEntry = newValue
            editTextField.textContentType = .oneTimeCode
        }
    }
    
    var bitmaskValue: BaseBitmaskProtocol? {
        willSet {
            guard let bitmasktResult: Int = newValue?.getBitmaskValue() else {return}
            bitmask = bitmasktResult
        }
    }
    
    private var bitmask: Int = 0
    
    var errorMessage: String?
    
    var heightConstraint: NSLayoutConstraint!
    
    var failureFunc: ( () -> Bool )?
    
    lazy var editTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let errorLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(editTextField)
        addSubview(errorLabel)
        
        let editTextConstraints = [
            editTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            editTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            editTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let errorLabelConstraints = [
            errorLabel.leadingAnchor.constraint(equalTo: editTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: editTextField.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: editTextField.bottomAnchor)
        ]
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate(editTextConstraints)
        NSLayoutConstraint.activate(errorLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gainFocus(){
        editTextField.becomeFirstResponder()
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField){
        if let mask = maskField {
            if let res = mask.process(value: textField.text!) {
                textField.text = res
            }
        }
        
        guard let failFunc = failureFunc else { return }
        
        if failFunc() {
            errorLabel.text = errorMessage
            heightConstraint.constant = 70
            delegate?.textFieldDidChanged(isValid: false, bitmask: bitmask, text: textField.text!)
        } else {
            errorLabel.text = ""
            heightConstraint.constant = 50
            delegate?.textFieldDidChanged(isValid: true, bitmask: bitmask, text: textField.text!)
        }
        
        
        layoutIfNeeded()
    }
}
