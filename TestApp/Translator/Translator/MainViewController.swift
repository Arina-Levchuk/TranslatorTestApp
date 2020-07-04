//
//  MainViewController.swift
//  Translator
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

//  MARK: - Properties

    let inputField = UITextField()
    let sendButton = UIButton.init(type: .custom)
    let horizontalStackView = UIStackView()
    let tableView = UITableView.init(frame: .zero)
    let cellId = "cellId"
    var arrayOfResponses: [Result] = []
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
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.dataSource = self
//      ??
        tableView.rowHeight = UITableView.automaticDimension
        
        self.inputField.delegate = self
        
        setUpKeyboard()
        
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
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
        tableView.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor).isActive              = true
    }
    
    func configureHorizontalStackView() {
        view.addSubview(horizontalStackView)
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.spacing = 10
        horizontalStackView.heightAnchor.constraint(equalToConstant: 35).isActive = true

        addElementsToHorizontalStack()
        setStackViewConstraints()
    }
    
    func addElementsToHorizontalStack() {
        setUpInputField()
        
        horizontalStackView.addArrangedSubview(inputField)
        horizontalStackView.addArrangedSubview(sendButton)
        
        sendButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        sendButton.setImage(UIImage(named: "sendButton"), for: .normal)
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
        if let translator = self.selectedTranslator {
            guard let translatorURL = translator.url else { return }
            guard let textToTranslate = self.inputField.text else { return }
//            dismissKeyboard()
//            sendToTranslate(address: translatorURL!, text: textToTranslate)
            let result = sendToTranslate(address: translatorURL, text: textToTranslate)
//            print(result)
            
            self.arrayOfResponses.append(result)
            print(arrayOfResponses)

        }
    }
    
    func sendToTranslate(address: URL, text: String) -> Result {
        var requestResult = Result(textToTranslate: text)
        var url = address
        
        if let queryArray = selectedTranslator?.queryDict {
            for (item, value) in queryArray {
                url = url.append(item, value: value)
            }
        }
        
        url = url.append("text", value: text)
        print(url)
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                print("Client Error")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error: \(error!.localizedDescription)")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type")
                return
            }
//  TODO: DispatchQueue??
            DispatchQueue.main.async {
                guard let responseData = data else {
                    print("Error: no response data.")
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let decodedData = try! decoder.decode(DecodedResponse.self, from: responseData)
                    if decodedData.text != nil {
                        requestResult.yandexTranslatorResult = decodedData.text
//                        print(decodedData.text)
                    } else {
                        requestResult.funTranslatorResult = decodedData.translated
//                        print(decodedData.translated)
                    }
                    
                    print(requestResult)
//                    self.arrayOfResponses.append(Result(text: decodedData.text ?? nil, translated: decodedData.translated ?? nil)!)
//                    print(self.arrayOfResponses)
                    
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }

        }
        task.resume()
        return requestResult
    }
    
    
        
}

// MARK: - Extension

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfResponses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
        let translationResult = arrayOfResponses[indexPath.row]
        cell.translation = translationResult
        
//        cell.textFromInputFieldView.text = "\(translationResult.textToTranslate)"
//        if translationResult.translationFromFunTranslator != nil || translationResult.translationFromYandex != nil {
//            cell.translationTextView.text = "\(translationResult.translationFromFunTranslator ?? translationResult.translationFromYandex?.joined(separator: ""))"
//        } else {
//            cell.translationTextView.text = "Error. Please retry"
//            cell.translationTextView.textColor = .red
//        }

        
//        ???
//        if translation.text != nil {
//            cell.textLabel?.text = translation.text?.joined(separator: "")
//        } else if translation.translated != nil {
//            cell.textLabel?.text = translation.translated
//        }

        return cell
    }
}
    
    
extension MainViewController: TranslatorsListVCDelegate {
    func newTranslatorSelected(translator: Translator) {
        self.selectedTranslator = translator
    }
}

