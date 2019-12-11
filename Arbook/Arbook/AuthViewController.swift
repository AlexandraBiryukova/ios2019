//
//  AuthViewController.swift
//  Firebase
//
//  Created by erumaru on 10/30/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase


class AuthViewController: UIViewController, AuthUIDelegate {
    // MARK: - Constants
    
    private struct Constants {
        static let phoneTextFieldPlaceholder = "Type your number"
        static let sendSMSText = "Send"
    }
    
    
    // MARK: - Outlets
    lazy var phoneTextField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 10
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        view.leftViewMode = .always
        view.backgroundColor = #colorLiteral(red: 0.951928382, green: 0.9692964829, blue: 1, alpha: 0.1953400088)
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
    
    lazy var sendSMSButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.sendSMSText, for: .normal)
        button.titleLabel?.font=UIFont(name: "Avenir Next", size: 17)
        button.addTarget(self, action: #selector(sendSMS), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.541, green: 0.169, blue: 0.886, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    lazy var label: UILabel = {
        let button = UILabel()
        button.font=UIFont(name: "Avenir Next", size: 34)
        button.textColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        button.text="ARBOOK"
        button.textAlignment = .center
        return button
    }()
    // MARK: - Actions
    @objc private func sendSMS() {
        guard let phone = phoneTextField.text else { return }
        AuthManager.shared.sendSMS(phone: phone, uiDelegate: self) { [weak self] in
            guard let self = self else { return }
            let vc = VerifyCodeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
//        print("Here")
        self.navigationController?.navigationBar.tintColor=UIColor.white
        self.title = "Log in"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,
             NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 21)!]
        self.navigationController?.navigationBar.barTintColor=#colorLiteral(red: 0.5491973758, green: 0.2751287222, blue: 0.8883674145, alpha: 1)
        markup()
    }
    private func markup() {
        [phoneTextField, sendSMSButton,label].forEach { view.addSubview($0) }
        label.snp.makeConstraints() {
            $0.top.equalTo(view.snp.topMargin).offset(48)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        phoneTextField.snp.makeConstraints() {
            $0.top.equalTo(label.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        sendSMSButton.snp.makeConstraints() {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
    }
}
extension UIView {
    func addBackground() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "Image-2.jpg")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
}}
