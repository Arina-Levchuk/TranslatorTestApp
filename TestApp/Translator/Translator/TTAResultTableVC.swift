//
//  TTAResultTableVC.swift
//  Translator
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TTAResultTableVC: UIViewController, UITextFieldDelegate {

//  MARK: - Properties
    
    lazy var coreDataStack = TTACoreDataStack(modelName: "Translator")

    lazy var fetchedResultsController: NSFetchedResultsController<TTATranslatorResult> = {
        let fetchRequest: NSFetchRequest<TTATranslatorResult> = TTATranslatorResult.fetchRequest()
        
        let sort = NSSortDescriptor(key: #keyPath(TTATranslatorResult.timeStamp), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    let inputField = UITextField()
    let sendButton = UIButton.init(type: .custom)
    let inputContainerView = UIView()
    let horizontalStackView = UIStackView()
    let tableView = UITableView.init(frame: .zero)
    
    var inputViewBottomConstraint: NSLayoutConstraint?
    
    var selectedTranslator: TTATranslator? = nil

//  MARK: - View lifecycle
    
    var translators: [TTATranslator] = [
                                            TTATranslator(name: "Yoda translator", url: URL(string: "https://api.funtranslations.com/translate/yoda.json")),
                                            TTATranslator(name: "Klingon translator", url: URL(string: "https://api.funtranslations.com/translate/klingon.json")),
                                            TTATranslator(name: "Shakespeare translator", url: URL(string: "https://api.funtranslations.com/translate/shakespeare.json")),
                                            TTATranslator(name: "Yandex translate", url: URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate"), queryDict: ["key": "trnsl.1.1.20200504T182931Z.03785aecf85306af.7922af70293ac75cde1e43526b6b4c4cd682cf8e", "lang": "en-ru"]),
                                            TTATranslator(name: "Valyrian translator", url: URL(string: "https://api.funtranslations.com/translate/valyrian.json"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
        
        self.selectedTranslator = translators.first
        
        setUpNavBarAppearance()
        setUpTableView()
        configureInputContainerView()

        self.tableView.register(TTATranslatorResultCell.self, forCellReuseIdentifier: TTATranslatorResultCell.reuseIdentifier)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        tableView.tableFooterView = UIView()
//        tableView.keyboardDismissMode = .onDrag

        self.inputField.delegate = self

        setUpKeyboardShowing()
        
//        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapRecognizer)
//
//        tapRecognizer.cancelsTouchesInView = false // solves the problem of intefering with didSelectRow method
        
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)

    }


//    MARK: - Layout
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: inputContainerView.frame.height, right: 0)
//        tableView.scrollIndicatorInsets = tableView.contentInset
//    }
    
    func setUpNavBarAppearance() {
        view.backgroundColor = .white
        navigationItem.title = "Results"
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
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive      = true

    }
        
    func configureInputContainerView() {
        view.addSubview(inputContainerView)
        
        inputContainerView.addSubview(horizontalStackView)
        configureHorizontalStackView()
        
        inputContainerView.translatesAutoresizingMaskIntoConstraints                                             = false
        inputContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        inputContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        inputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        inputViewBottomConstraint = NSLayoutConstraint(item: inputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(inputViewBottomConstraint!)
        
        inputContainerView.centerXAnchor.constraint(equalTo: horizontalStackView.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: horizontalStackView.centerYAnchor).isActive = true
        
        inputContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        inputContainerView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        inputContainerView.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
        ])
        
    }
    
    func configureHorizontalStackView() {
        addElementsToHorizontalStack()
        setHorizontalStackConstraints()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.spacing = 10
        horizontalStackView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func addElementsToHorizontalStack() {
        setUpInputField()
        setUpSendButton()
        
        horizontalStackView.addArrangedSubview(inputField)
        horizontalStackView.addArrangedSubview(sendButton)
    }
    
    func setHorizontalStackConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints                                                     = false
        horizontalStackView.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 20).isActive    = true
        horizontalStackView.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -20).isActive = true

    }
        
    func setUpKeyboardShowing() {
//      The View Controller receives notification when the keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

//      The View Controller receives notification when the keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
//      [Return] button closes the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputField.resignFirstResponder()
        return true
    }
    
    func setUpTableViewScroll() {
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: inputContainerView.frame.height, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
       
//      TODO: recheck with 1 cell before acvieving the if condition
        if tableView.contentSize.height > (view.safeAreaLayoutGuide.layoutFrame.height - inputContainerView.frame.height) {
            self.tableView.contentOffset = CGPoint(x: 0, y: tableView.contentSize.height)
        } else {
            self.tableView.contentOffset = CGPoint.zero
        }
    }
    
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
        
        inputField.adjustsFontSizeToFitWidth = true
        
    }
    
    func setUpSendButton() {
        sendButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        sendButton.setImage(UIImage(named: "sendButton"), for: .normal)
    }


// MARK: - Selectors
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let userInfo = notification.userInfo, let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let keyboardAnimationDuration = ((userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]) as? Double) else { return }
//        print(keyboardAnimationDuration)
        
        UIView.animate(withDuration: keyboardAnimationDuration) {
            self.inputViewBottomConstraint?.constant = -keyboardSize.height + self.view.safeAreaInsets.bottom
            self.view.layoutIfNeeded()
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize.height + inputContainerView.frame.height), right: 0)
        self.tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
        
        if tableView.contentSize.height > (keyboardSize.height + inputContainerView.frame.height) {
            tableView.contentOffset = CGPoint(x: 0, y: tableView.contentSize.height)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        guard let userInfo = notification.userInfo, let keyboardAnimationDuration = ((userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]) as? Double) else { return }

        setUpTableViewScroll()
        
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: inputContainerView.frame.height, right: 0)
//        tableView.scrollIndicatorInsets = tableView.contentInset
//
////      TODO: recheck with 1 cell before acvieving the if condition
//        if tableView.contentSize.height > (view.safeAreaLayoutGuide.layoutFrame.height - inputContainerView.frame.height) {
//            self.tableView.contentOffset = CGPoint(x: 0, y: tableView.contentSize.height)
//        } else {
//            self.tableView.contentOffset = CGPoint.zero
//        }
        
        UIView.animate(withDuration: keyboardAnimationDuration) {
            self.inputViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
        
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
            
            let translationRequest = TTATranslatorResult(textToTranslate: inputField.text!, insertInto: coreDataStack.managedContext)
            
            getTranslation(to: translatorURL, with: translationRequest, completionHandler: { [weak self] (result, error) in
                if result != nil {
                    translationRequest.setResponseStatus?(.success)
                } else {
                    translationRequest.setResponseStatus?(.failure)
                }
                self?.coreDataStack.saveContext()
                DispatchQueue.main.async {
                    self?.inputField.text = nil
                }
            })
          setUpTableViewScroll()
        }
    }
    
// MARK: - Methods
        
    func getTranslation(to address: URL, with request: TTATranslatorResult, completionHandler: @escaping (TTATranslatorResult?, Error?) -> Void) {
            var url = address
//            let result = request
        
            if let queryArray = selectedTranslator?.queryDict {
                for (key, value) in queryArray {
                    url = url.append(key, value: value)
                }
            }

        url = url.append("text", value: request.textToTranslate)
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
                            request.translation = decodedData.text?.joined(separator: "")
                        } else {
                            request.translation = decodedData.translated
                        }
                        completionHandler(request, nil)
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

extension TTAResultTableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TTATranslatorResultCell.reuseIdentifier, for: indexPath) as! TTATranslatorResultCell
        
        let result = self.fetchedResultsController.object(at: indexPath)
        
        cell.cellTitle.text = result.textToTranslate
        
        switch result.responseStatus {
        case TTATranslatorResult.ResponseStatus.success.description:
            cell.showSpinner(animate: false)
            cell.cellSubtitle.text = result.translation
            cell.cellSubtitle.textColor = .black
        case TTATranslatorResult.ResponseStatus.failure.description:
            cell.showSpinner(animate: false)
            cell.cellSubtitle.text = "Error. Tap to retry"
            cell.cellSubtitle.textColor = .red
        default:
            cell.showSpinner(animate: true)
//            cell.cellSubtitle.text = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: TTATranslatorResultCell.EditingStyle, forRowAt indexPath: IndexPath) {

        guard editingStyle == .delete else { return }
        let result = self.fetchedResultsController.object(at: indexPath)
        coreDataStack.managedContext.delete(result)
        
        coreDataStack.saveContext()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row is selected!")
        
        let result = self.fetchedResultsController.object(at: indexPath)
        
        guard result.responseStatus == TTATranslatorResult.ResponseStatus.failure.description else { return }

        getTranslation(to: (self.selectedTranslator?.url)!, with: result, completionHandler: { [weak self] (newResult, error) in
            if newResult != nil {
                result.setResponseStatus?(.success)
            } else {
                result.setResponseStatus?(.failure)
            }
            self!.coreDataStack.saveContext()
        })
    
    }
    
}
    
extension TTAResultTableVC: TranslatorsListVCDelegate {
    func newTranslatorSelected(translator: TTATranslator) {
        self.selectedTranslator = translator
    }
}

extension TTAResultTableVC: NSFetchedResultsControllerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
        
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            print("Unexpected NSFetchedResultsChangeType")
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

}
