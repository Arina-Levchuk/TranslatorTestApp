//
//  TTATranslationResultTableVC.swift
//  Translator
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TTATranslationResultTableVC: UIViewController, UITextFieldDelegate {

//  MARK: - Properties
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let inputField = UITextField()
    let sendButton = UIButton.init(type: .custom)
    let horizontalStackView = UIStackView()
    let tableView = UITableView.init(frame: .zero)

    var results: [TTATranslatorResult] = []

    var selectedTranslator: TTATranslator? = nil
//    var delegate: RequestProtocolDelegate?
//  MARK: - View lifecycle
    
    var translators: [TTATranslator] = [
                                            TTATranslator(name: "Yoda translator", url: URL(string: "https://api.funtranslations.com/translate/yoda.json")),
                                            TTATranslator(name: "Klingon translator", url: URL(string: "https://api.funtranslations.com/translate/klingon.json")),
                                            TTATranslator(name: "Shakespeare translator", url: URL(string: "https://api.funtranslations.com/translate/shakespeare.json")),
                                            TTATranslator(name: "Yandex translate", url: URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate"), queryDict: ["key": "trnsl.1.1.20200504T182931Z.03785aecf85306af.7922af70293ac75cde1e43526b6b4c4cd682cf8e", "lang": "en-ru"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.results = try context.fetch(TTATranslatorResult.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        self.selectedTranslator = translators.first
        
        setUpNavBarAppearance()
        
        configureHorizontalStackView()
        setUpTableView()
        
        self.tableView.register(TTATranslatorResultCell.self, forCellReuseIdentifier: TTATranslatorResultCell.reuseIdentifier)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.tableFooterView = UIView()

        self.inputField.delegate = self
        
        setUpKeyboard()
        
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
//        sendButton.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)

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
        NotificationCenter.default.addObserver(self, selector: #selector(TTATranslationResultTableVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

//      The View Controller receives notification when the keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(TTATranslationResultTableVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapRecognizer)
        
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
            self.navigationController?.pushViewController(TTATranslatorsListVC(selectedTranslator: translator, allTranslators: self.translators, delegate: self), animated: true)
        }
    }

    @objc func didTapSendButton() {
        if let translator = self.selectedTranslator {
            guard let translatorURL = translator.url else { return }
            guard self.inputField.text != nil && self.inputField.text != "" else { return }
            dismissKeyboard()
            let translationRequest = TTATranslatorResult(textToTranslate: self.inputField.text!, translation: nil, responseStatus: nil, insertIntoManagedObjectContext: context)
            appDelegate.saveContext()
            self.results.append(translationRequest)
            
            getTranslation(to: translatorURL, with: translationRequest, completionHandler: { [weak self] (result, error) in
                if result != nil {
                    translationRequest.setResponseStatus?(.success)
//                    self.appDelegate.saveContext()
                } else {
                    translationRequest.setResponseStatus?(.failure)
//                   self.appDelegate.saveContext()
                }
                self?.appDelegate.saveContext()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.inputField.text = nil
                }
            })
            
        }
    }
    
// MARK: - Methods
    
    func getTranslation(to address: URL, with request: TTATranslatorResult, completionHandler: @escaping (TTATranslatorResult?, Error?) -> Void) {
            var url = address
            let result = request
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        
            if let queryArray = selectedTranslator?.queryDict {
                for (key, value) in queryArray {
                    url = url.append(key, value: value)
                }
            }

        url = url.append("text", value: result.textToTranslate)
            print(url)
            
            let getRequest = URLRequest(url: url)
                    
            let session = URLSession.shared
            let task = session.dataTask(with: getRequest) { (data, response, error) in
                if error != nil || data == nil {
                    completionHandler(nil, error)
                    print("Client error!")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    completionHandler(nil, error)
                    print("Server error!")
                    return
                }
                
                guard let mime = response.mimeType, mime == "application/json" else {
                    completionHandler(nil, error)
                    print("Wrong MIME type!")
                    return
                }
                
                DispatchQueue.main.async {
                    guard let responseData = data else {  return  }
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try! decoder.decode(TTADecodedResponse.self, from: responseData)
                        
                        if decodedData.text != nil {
                            result.translation = decodedData.text?.joined(separator: "")
                        } else {
                            result.translation = decodedData.translated
                        }
                        completionHandler(result, nil)
                    } catch {
                        completionHandler(nil, error)
                        print("JSON parsing error")
                    }
                }
            }
            task.resume()
        }

}

// MARK: - Extensions

extension TTATranslationResultTableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
//        return self.arrayOfResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TTATranslatorResultCell.reuseIdentifier, for: indexPath) as! TTATranslatorResultCell
        let result = self.results[indexPath.row]
        
        cell.cellTitle.text = result.textToTranslate
        
        switch result.responseStatus {
        case TTATranslatorResult.ResponseStatus.success.description:
            cell.showSpinner(animate: false)
            cell.cellSubtitle.text = result.translation
        case TTATranslatorResult.ResponseStatus.failure.description:
            cell.showSpinner(animate: false)
            cell.cellSubtitle.text = "Error. Tap to retry"
            cell.cellSubtitle.textColor = .red
        default:
            cell.showSpinner(animate: true)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: TTATranslatorResultCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }

        let result = results[indexPath.row]
        context.delete(result)
        self.results.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)

        appDelegate.saveContext()
    }
    
//  TODO: to resend request to translate text after tapping on the cell with error
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ROW IS TAPPED!!!")
        
        let result = self.results[indexPath.row]
        
        if result.responseStatus == "failure" {
            getTranslation(to: (self.selectedTranslator?.url)!, with: result) { [weak self] (newResult, error) in
                if newResult != nil {
                    newResult!.setResponseStatus?(.success)
                    newResult!.translation = "SUCCESS"
    //                self.appDelegate.saveContext()
                } else {
    //            To set conditions
                    result.setResponseStatus?(.success)
                    result.translation = "FAILURE"
                    self?.appDelegate.saveContext()
                }
                self?.appDelegate.saveContext()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
        }
    }
}
    
extension TTATranslationResultTableVC: TranslatorsListVCDelegate {
    func newTranslatorSelected(translator: TTATranslator) {
        self.selectedTranslator = translator
    }
}

