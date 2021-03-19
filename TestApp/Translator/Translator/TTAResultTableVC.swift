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


class TTAResultTableVC: UIViewController {

//  MARK: - Properties

    lazy var coreDataStack = TTACoreDataStack(modelName: "Translator")
    
    lazy var fetchedResultsController: NSFetchedResultsController<TTATranslatorResult> = {
        let fetchRequest: NSFetchRequest<TTATranslatorResult> = TTATranslatorResult.fetchRequest()
        
        let sort = NSSortDescriptor(key: #keyPath(TTATranslatorResult.timeStamp), ascending: true)
        fetchRequest.sortDescriptors = [sort]

        fetchRequest.fetchBatchSize = 10
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    let inputField = UITextView()
    var inputFieldTopConstraint: NSLayoutConstraint?
    private let limitedInputFieldHeight: CGFloat = 100
    
    private var inputFieldIsOversized = false {
        
        didSet {
            
            guard oldValue != inputFieldIsOversized else { return }
            inputField.reloadInputViews()
            inputField.isScrollEnabled = inputFieldIsOversized
            inputField.setNeedsUpdateConstraints()
                        
        }
        
    }
        
    let textViewPlaceholder: UILabel = {
        let tvPlaceholder = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        tvPlaceholder.text = TTAResultTableVCKeys.localizedString(type: .inputFielLabel)
//        tvPlaceholder.text = "Enter a word..."
        tvPlaceholder.textColor = .systemGray4
        tvPlaceholder.font = UIFont.systemFont(ofSize: 17.0)
//        tvPlaceholder.textAlignment = .natural
        return tvPlaceholder
    }()
    
    let sendButton = UIButton.init(type: .custom)
    
    let inputContainerView = UIView()
    var inputViewBottomConstraint: NSLayoutConstraint?
    
    let tableView = UITableView.init(frame: .zero)
    
    var selectedTranslator: TTATranslator? = nil
    
    var selectedLanguage: TTATranslatorLanguage? = nil

//  MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("VIEW DID LOAD")
        
        view.backgroundColor = .systemBackground
        
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
        
        setupNavBarAppearance()
        setUpTableView()
        configureInputContainerView()

        self.tableView.register(TTATranslatorResultCell.self, forCellReuseIdentifier: TTATranslatorResultCell.reuseIdentifier)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.tableFooterView = UIView()
//        tableView.keyboardDismissMode = .onDrag

        self.inputField.delegate = self

        setUpKeyboardShowing()
        
//        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
//        tapRecognizer.cancelsTouchesInView = false // solves the problem of intefering with didSelectRow method
//        view.addGestureRecognizer(tapRecognizer)
        
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        
        self.selectedLanguage = TTASettingsListVC.allLanguages.first
        self.selectedTranslator = TTASettingsListVC.allTranslators.first
        
    }
            
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onAppLangDidChange(_:)), name: .didChangeAppLang, object: nil)

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        inputField.layer.borderColor = UIColor.systemGray5.cgColor
    }
            
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.inputFieldTopConstraint?.constant = limitedInputFieldHeight
        
    }
    
        
    func textViewDidChange(_ textView: UITextView) {
        
        inputFieldIsOversized = inputField.contentSize.height > limitedInputFieldHeight
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: inputContainerView.frame.height, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        self.view.endEditing(true)
//        NotificationCenter.default.removeObserver(self)
    }
    
//  MARK:- Layout
    
    func setupNavBarAppearance() {
        
//        navigationController?.navigationBar.barTintColor = .systemGray6
        navigationItem.title = TTAResultTableVCKeys.localizedString(type: .title)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(moveToTranslatorsList))
        navigationItem.rightBarButtonItem = settingsButton
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
        
        inputContainerView.addSubview(inputField)
        inputContainerView.addSubview(sendButton)
        setUpInputFieldAppearance()
        setUpSendButton()
        
        inputContainerView.translatesAutoresizingMaskIntoConstraints                                            = false
        inputContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive   = true
        inputContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        inputContainerView.topAnchor.constraint(equalTo: inputField.topAnchor, constant: -5).isActive           = true
        
        inputViewBottomConstraint = NSLayoutConstraint(item: inputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(inputViewBottomConstraint!)
        
//        inputContainerView.backgroundColor = .purple
        
//      Blur container view
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
    
    func setUpInputFieldAppearance() {
        
        inputField.backgroundColor = .systemBackground
        inputField.layer.cornerRadius = 15
        inputField.layer.borderWidth = 1
        inputField.layer.borderColor = UIColor.systemGray5.cgColor
        inputField.keyboardAppearance = .default
        inputField.keyboardType = .default

        inputField.textColor = .label
        inputField.determineTextDirection()

        inputField.font = UIFont.systemFont(ofSize: 17.0)
        inputField.textContainerInset.left = 10
        inputField.textContainerInset.right = inputField.textContainerInset.left
        
        inputField.isScrollEnabled = false
        
        inputField.addSubview(textViewPlaceholder)
        setupTextViewPlaceholder()
        
        setupInputFieldConstraints()
                
    }
    
    func setupTextViewPlaceholder() {
        
        textViewPlaceholder.isHidden = false
        textViewPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        textViewPlaceholder.leadingAnchor.constraint(equalTo: inputField.leadingAnchor, constant: 10).isActive = true
        textViewPlaceholder.trailingAnchor.constraint(equalTo: inputField.trailingAnchor).isActive = true
        textViewPlaceholder.centerXAnchor.constraint(equalTo: inputField.centerXAnchor).isActive = true
        textViewPlaceholder.centerYAnchor.constraint(equalTo: inputField.centerYAnchor).isActive = true
        
        textViewPlaceholder.determineTextDirection()
        
    }
    
    func setupInputFieldConstraints() {
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10).isActive = true
        inputField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 20).isActive = true
        inputField.bottomAnchor.constraint(equalTo: sendButton.bottomAnchor).isActive = true
        
        inputFieldTopConstraint = NSLayoutConstraint(item: inputField, attribute: .height, relatedBy: .equal, toItem: inputField, attribute: .height, multiplier: 1, constant: 35)
        
        view.addConstraint(inputFieldTopConstraint!)
        
    }
    
    func setUpSendButton() {
        sendButton.setImage(UIImage(named: "sendButton"), for: .normal)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        
        sendButton.leadingAnchor.constraint(equalTo: inputField.trailingAnchor, constant: 10).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -20).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -5).isActive = true
    }
        
    func setUpKeyboardShowing() {
//      The View Controller receives notification when the keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

//      The View Controller receives notification when the keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func setUpTableViewScroll() {
        
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: inputContainerView.frame.height, right: 0)
//        tableView.scrollIndicatorInsets = tableView.contentInset

//        if tableView.contentSize.height > (view.safeAreaLayoutGuide.layoutFrame.height - inputContainerView.frame.height) {
        if tableView.contentSize.height > inputContainerView.frame.height {
            self.tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentSize.height), animated: false)
        } else {
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
        }
    }
    
// MARK: - Selectors
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let userInfo = notification.userInfo, let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let keyboardAnimationDuration = ((userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]) as? Double) else { return }
//        print(keyboardAnimationDuration)
        
//        TODO: SCROLL FOR keyboardWillSHOW
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize.height + inputContainerView.frame.height), right: 0)
        self.tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
        
        let inputViewHeight = view.safeAreaLayoutGuide.layoutFrame.height - (keyboardSize.height + inputContainerView.frame.height)

        if tableView.contentSize.height > inputViewHeight {
            tableView.contentOffset = CGPoint(x: 0, y: tableView.contentSize.height)
        } else {
            tableView.contentOffset = CGPoint.zero
        }
        
        UIView.animate(withDuration: keyboardAnimationDuration) {
            self.inputViewBottomConstraint?.constant = -keyboardSize.height + self.view.safeAreaInsets.bottom
            self.view.layoutIfNeeded()
        }

    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        guard let userInfo = notification.userInfo, let keyboardAnimationDuration = ((userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]) as? Double) else { return }

//        TODO: SCROLL FOR keyboardWillHIDE
//        setUpTableViewScroll()
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: inputContainerView.frame.height, right: 0)
        self.tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
        
//        let inputViewHeight = view.safeAreaLayoutGuide.layoutFrame.height - (keyboardSize.height + inputContainerView.frame.height)

//        if tableView.contentSize.height > inputContainerView.frame.height {
//            tableView.contentOffset = CGPoint(x: 0, y: tableView.contentSize.height)
//        } else {
//            tableView.contentOffset = CGPoint.zero
//        }
        
        UIView.animate(withDuration: keyboardAnimationDuration) {
            self.inputViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func moveToTranslatorsList() {
        if let translator = self.selectedTranslator {
            guard let language = self.selectedLanguage else { return }

            self.navigationController?.pushViewController(TTASettingsListVC(selectedTranslator: translator, selectedLanguage: language, delegate: self), animated: true)
        }
    }
    
    @objc func didTapSendButton() {
        if let translator = self.selectedTranslator {
            guard let translatorURL = translator.url else { return }
            guard self.inputField.text != nil && self.inputField.text != "" else { return }

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
                    self?.textViewPlaceholder.isHidden = false
                }
            })
          dismissKeyboard()
          setUpTableViewScroll()
            
        }
    }
    
    @objc func onAppLangDidChange(_ notification: NSNotification) {

        navigationItem.title = TTAResultTableVCKeys.localizedString(type: .title)

        textViewPlaceholder.text = TTAResultTableVCKeys.localizedString(type: .inputFielLabel)
        textViewPlaceholder.determineTextDirection()
        
        self.tableView.reloadData()
        
        inputField.determineTextDirection()

    }
    
    @objc func didTapLocationButton(_ sender: UIButton) {

        if let superview = sender.superview, let cell = superview.superview as? TTATranslatorResultCell {
            if let cellIndexPath = self.tableView.indexPath(for: cell) {
                let resultObject = self.fetchedResultsController.object(at: cellIndexPath)

                self.navigationController?.pushViewController(TTAUserLocationVC(latitude: resultObject.latitude, longitude: resultObject.longitude), animated: true)
                print("Cell's userLocation LAT: \(resultObject.latitude), LONG: \(resultObject.longitude)")
            }
        }
    }
    
    @objc func didTapRetryButton(_ sender: UIButton) {
//        print("BUTTON IS TAPPED")
        if let superview = sender.superview, let cell = superview.superview?.superview as? TTATranslatorResultCell {
            if let cellIndexPath = self.tableView.indexPath(for: cell) {
                let result = self.fetchedResultsController.object(at: cellIndexPath)

                if let translator = self.selectedTranslator {
                    if result.responseStatus == TTATranslatorResult.ResponseStatus.failure.description {
                        guard let translatorURL = translator.url else { return }

                        getTranslation(to: translatorURL, with: result, completionHandler: { [weak self] (newResult, error) in
                            if newResult != nil {
                                result.setValue(TTATranslatorResult.ResponseStatus.success.description, forKey: #keyPath(TTATranslatorResult.responseStatus))
                            } else {
                                result.setValue(TTATranslatorResult.ResponseStatus.failure.description, forKey: #keyPath(TTATranslatorResult.responseStatus))
                            }
                            self?.coreDataStack.saveContext()
                        })
                    }
                }
            }
        }
    }
    
    
// MARK: - Custom Methods
        
    func getTranslation(to address: URL, with request: TTATranslatorResult, completionHandler: @escaping (TTATranslatorResult?, Error?) -> Void) {
            var url = address
        
            if let queryArray = selectedTranslator?.queryDict {
                for (key, value) in queryArray {
                    url = url.append(key, value: value)
                    url = url.append("lang", value: "en-\(selectedLanguage!.langCode)")
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
        
//        cell.accessoryType = .disclosureIndicator

        cell.cellTitle.text = result.textToTranslate
                
//        cell.locationButton.addTarget(self, action: #selector(didTapLocationButton), for: .touchUpInside)
        cell.retryButton.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
                
        switch result.responseStatus {
        case TTATranslatorResult.ResponseStatus.success.description:
            cell.showSpinner(animate: false)
            cell.cellSubtitle.text = result.translation
            cell.cellSubtitle.textColor = .label
        case TTATranslatorResult.ResponseStatus.failure.description:
            cell.showSpinner(animate: false)
            cell.cellSubtitle.text = TTAResultTableVCKeys.localizedString(type: .cellErrorMessage)
            cell.cellSubtitle.textColor = .systemRed
            cell.retryButton.isHidden = false
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
//        print("Row is selected!")
        
        let result = self.fetchedResultsController.object(at: indexPath)
        
        self.navigationController?.pushViewController(TTAUserLocationVC(latitude: result.latitude, longitude: result.longitude), animated: true)
        
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

extension TTAResultTableVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if inputField.text != "" || inputField.text != nil {
            textViewPlaceholder.isHidden = true
        }
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if inputField.text == "" || inputField.text == nil {
            textViewPlaceholder.isHidden = false
        }
    }
        
    
//  [Return] button closes the keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if (text as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
            return true
        } else {
            inputField.resignFirstResponder()
            return false
        }
    }
}

extension TTAResultTableVC: TTASettingsListDelegate {
    
    func newLanguageSelected(language: TTATranslatorLanguage) {
        self.selectedLanguage = language
    }
    
    func newTranslatorIsSelected(translator: TTATranslator) {
        self.selectedTranslator = translator
    }
    
}
