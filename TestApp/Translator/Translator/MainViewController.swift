//
//  MainViewController.swift
//  Translator
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController, UITextFieldDelegate {

//  MARK: - Properties

    let inputField = UITextField()
    let sendButton = UIButton.init(type: .custom)
    let horizontalStackView = UIStackView()
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
    var arrayOfResponses = [Result]()
    
//    var textToTranslate: String?
//    var translatorURL: URL?
    var selectedTranslator: Translator? = nil
//    var delegate: RequestProtocolDelegate?
//  MARK: - View lifecycle
    
    var translators: [Translator] = [
                                            Translator(name: "Yoda translator", url: URL(string: "https://api.funtranslations.com/translate/yoda.json")),
                                            Translator(name: "Klingon translator", url: URL(string: "https://api.funtranslations.com/translate/klingon.json")),
                                            Translator(name: "Shakespeare translator", url: URL(string: "https://api.funtranslations.com/translate/shakespeare.json")),
                                            Translator(name: "Yandex translate", url: URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate"), queryDict: ["key": "trnsl.1.1.20200504T182931Z.03785aecf85306af.7922af70293ac75cde1e43526b6b4c4cd682cf8e", "lang": "en-ru"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedTranslator = translators.first
        
        setUpNavBarAppearance()
        
        configureHorizontalStackView()
        setUpTableView()
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.inputField.delegate = self
        
        setUpKeyboard()
        
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
    }
    


//    MARK: - Layout stuff
    func setUpNavBarAppearance() {
        view.backgroundColor = .white
        navigationItem.title = "Translator"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let listOfTranslatorsButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(moveToList))
        navigationItem.rightBarButtonItem = listOfTranslatorsButton
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints                                             = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive            = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive    = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive  = true
//        tableView.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: -2).isActive = true
        tableView.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor).isActive = true
    }
    
    func configureHorizontalStackView() {
        view.addSubview(horizontalStackView)
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.spacing = 10
//      TODO: To make configurable horizontal stack height (to fit the inputField's height)
        horizontalStackView.heightAnchor.constraint(equalToConstant: 35).isActive = true

        addElementsToHorizontalStack()
        setStackViewConstraints()
    }
    
    func addElementsToHorizontalStack() {
        setUpInputField()
        setUpSendButton()
        
        horizontalStackView.addArrangedSubview(inputField)
        horizontalStackView.addArrangedSubview(sendButton)
    }
    
    func setStackViewConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints                                                           = false
        horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive     = true
        horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive    = true
        horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func setUpKeyboard() {
//      The View Controller receives notification when the keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

//      The View Controller receives notification when the keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapRecognizer)
        
    }
    
//      [Return] button closes the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputField.resignFirstResponder()
        return true
    }
    
//  MARK: - View
    func setUpInputField() {
        inputField.backgroundColor = .white
        inputField.layer.cornerRadius = 17
        inputField.layer.borderWidth = 1
        inputField.layer.borderColor = UIColor.darkGray.cgColor
        inputField.placeholder = "Enter a word"
        inputField.clearButtonMode = .whileEditing
        inputField.keyboardAppearance = .light
        inputField.keyboardType = .default
        inputField.font = UIFont.systemFont(ofSize: 20.0)

//      Space from the leftView of the input field
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        inputField.leftViewMode = .always
        inputField.leftView = spacer

//      TODO: To make autoresizable inputField
        
    }
    
    func setUpSendButton() {
        sendButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        sendButton.setImage(UIImage(named: "sendButton"), for: .normal)
    }
    
// MARK: - Selectors
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//      If keyboard size isn't available - don't do anything
            return
        }
//      Moving root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
//      Moving back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func moveToList() {
        if let translator = self.selectedTranslator {
            self.navigationController?.pushViewController(TranslatorsListVC(selectedTranslator: translator, allTranslators: self.translators, delegate: self), animated: true)
        }
    }

    @objc func didTapSendButton() {
//      TODO: To close the keybord after tap on the Send Button
        dismissKeyboard()
        if let translator = self.selectedTranslator {
            guard let translatorURL = translator.url else { return }
            guard let textToTranslate = self.inputField.text else { return }

            sendToTranslate(to: translatorURL, with: textToTranslate, completionHandler: { result, error in
                if let result = result {
                    self.arrayOfResponses.append(result)
                    self.tableView.reloadData()
//                    print(self.arrayOfResponses)
                }
            })
        }
    }
    
    
    func sendToTranslate(to address: URL, with text: String, completionHandler: @escaping (Result?, Error?) -> Void) {
        var result = Result(textToTranslate: text, resultFromYandex: nil, resultFromFunTranslator: nil)

        var url = address
        
        if let queryArray = selectedTranslator?.queryDict {
            for (key, value) in queryArray {
                url = url.append(key, value: value)
            }
        }
       
        url = url.append("text", value: text)
        print(url)
        
        let request = URLRequest(url: url)
                
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            DispatchQueue.main.async {
                guard let responseData = data else {  return  }
                let decoder = JSONDecoder()
                do {
                    let decodedData = try! decoder.decode(DecodedResponse.self, from: responseData)
                    
                    if decodedData.text != nil {
                        result.resultFromYandex = decodedData.text
                    } else {
                        result.resultFromFunTranslator = decodedData.translated
                    }
                    print(result)
                    completionHandler(result, nil)

                } catch let parseError {
                    completionHandler(nil, parseError)
                    print("JSON parsing error", parseError)
                }
            }
        }
        task.resume()
    }
}
        


// MARK: - Extension

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfResponses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier, for: indexPath) as! CustomCell
        let translationResult = arrayOfResponses[indexPath.row]
        cell.translation = translationResult

        return cell
    }

//    TODO: Dynamic row height
//       func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
//// Make the first row larger to accommodate a custom cell.
//        if indexPath.row == 0 {
//            return 80
//        }
//
//// Use the default size for all other rows.
//        return UITableView.automaticDimension
//    }
    
}
    
    
extension MainViewController: TranslatorsListVCDelegate {
    func newTranslatorSelected(translator: Translator) {
        self.selectedTranslator = translator
    }
}

