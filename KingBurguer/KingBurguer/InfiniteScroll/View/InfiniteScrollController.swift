//
//  InfiniteScrollController.swift
//  KingBurguer
//
//  Created by angelo on 18/10/25.
//

import Foundation
import UIKit

class InfiniteScrollController: UIViewController {
    
    let infiniteScrollModel: InfiniteScrollModel
    
    init(infiniteScrollModel: InfiniteScrollModel) {
        self.infiniteScrollModel = infiniteScrollModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var simpleButton: LoadingButton = {
        let button = LoadingButton()
        button.title = "test"
        button.titleColor = .white
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapSimpleButton))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Infinte Scroll"
        view.backgroundColor = UIColor.systemBackground
        
        var texts: [UITextField] = []
        
        for i in 0..<30 {
            let text = UITextField()
            text.backgroundColor = .clear
            text.placeholder = "test - \(i)"
            text.borderStyle = .roundedRect
            text.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(text)
            texts.append(text)
        }
        
        container.addSubview(simpleButton)
        scroll.addSubview(container)
        view.addSubview(scroll)
        
        let scrollConstraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let heightConstraint = container.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        let containerConstraints = [
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
        ]
        
        for i in 0..<texts.count {
            if i == 0{
                NSLayoutConstraint.activate([
                    texts[i].leadingAnchor.constraint(equalTo: container.leadingAnchor),
                    texts[i].trailingAnchor.constraint(equalTo: container.trailingAnchor),
                    texts[i].heightAnchor.constraint(equalToConstant: 50.0),
                    texts[i].topAnchor.constraint(equalTo: container.topAnchor, constant: 10.0),
                ])
            } else {
                NSLayoutConstraint.activate([
                    texts[i].leadingAnchor.constraint(equalTo: container.leadingAnchor),
                    texts[i].trailingAnchor.constraint(equalTo: container.trailingAnchor),
                    texts[i].heightAnchor.constraint(equalToConstant: 50.0),
                    texts[i].topAnchor.constraint(equalTo: texts[i-1].bottomAnchor, constant: 10.0),
                ])
            }
        }
        
        let simpleButtonConstraints = [
            simpleButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            simpleButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            simpleButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20.0),
            simpleButton.topAnchor.constraint(greaterThanOrEqualTo: texts.last!.bottomAnchor, constant: 10.0),
            simpleButton.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        NSLayoutConstraint.activate(scrollConstraints)
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(simpleButtonConstraints)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func didTapSimpleButton(_ sender: UIButton){
        print("OK")
    }
    
    @objc func onKeyboardNotification(_ notification: Notification){
        let isVisibile = notification.name == UIResponder.keyboardWillShowNotification
        
        let keyboardFrame = isVisibile ? UIResponder.keyboardFrameEndUserInfoKey : UIResponder.keyboardFrameBeginUserInfoKey
        
        if let keyboardSize = (notification.userInfo?[keyboardFrame] as? NSValue)?.cgRectValue {
            onKeyboardChanged(isVisibile, height: keyboardSize.height)
        }
    }
    
    func onKeyboardChanged(_ isVisible: Bool, height: CGFloat){
        if(!isVisible){
            scroll.contentInset = .zero
            scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height, right: 0.0)
            scroll.contentInset = contentInsets
            scroll.scrollIndicatorInsets = contentInsets
        }
    }
}
