//
//  VerifyCodeViewController.swift
//  Firebase
//
//  Created by erumaru on 10/30/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class VerifyCodeViewController: UIViewController {
    // MARK: - Constants
     var ref: DatabaseReference!
    private struct Constants {
        static let phoneTextFieldPlaceholder = "Type code"
        static let sendSMSText = "Send code"
    }
    
    // MARK: - Outlets
    lazy var codeTextField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 10
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        view.leftViewMode = .always
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.187224912)
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textContentType = .telephoneNumber
        view.keyboardType = .phonePad
        view.returnKeyType = .done
        view.layer.borderColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        view.layer.borderWidth=2
        view.textColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.isEnabled=true
        view.attributedPlaceholder = NSAttributedString(string: Constants.phoneTextFieldPlaceholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        view.font=UIFont(name: "Avenir Next", size: 17)
        
        return view
    }()
    
    lazy var checkSMSButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.sendSMSText, for: .normal)
        button.titleLabel?.font=UIFont(name: "Avenir Next", size: 17)
        button.backgroundColor = UIColor(red: 0.541, green: 0.169, blue: 0.886, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(checkSMS), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    @objc private func checkSMS() {
        guard let code = codeTextField.text else { return }

        AuthManager.shared.checkSMS(code: code) { [weak self] message in
            guard let self = self else { return }
            if let message = message {
//                print(message)
                return
            }

            let vc = TabViewController()
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
       }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        self.navigationController?.navigationBar.tintColor=UIColor.white
        self.title = "Check code"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
             NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 21)!]
        self.navigationController?.navigationBar.barTintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)

        markup()
    }

    // MARK: - Markup
    private func markup() {
        view.backgroundColor = .white
        
        [codeTextField, checkSMSButton].forEach { view.addSubview($0) }
        
        codeTextField.snp.makeConstraints() {
            $0.top.equalTo(view.snp.topMargin).offset(48)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        
        checkSMSButton.snp.makeConstraints() {
            $0.top.equalTo(codeTextField.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
    }

}

