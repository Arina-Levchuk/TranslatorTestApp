//
//  TTAUserLocationVC.swift
//  Translator
//
//  Created by admin on 11/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TTAUserLocationVC: UIViewController {
    
    let testView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTestView()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpTestView() {

        
        testView.translatesAutoresizingMaskIntoConstraints = false
        testView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        testView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        testView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        testView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        testView.backgroundColor = .yellow
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
