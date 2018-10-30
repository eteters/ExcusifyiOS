//
//  SearchResultsViewController.swift
//  Excusify
//
//  Created by Evan Teters on 10/29/18.
//  Copyright © 2018 Evan Teters. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CloseButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
