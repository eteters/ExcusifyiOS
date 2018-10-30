//
//  SearchResultsViewController.swift
//  Excusify
//
//  Created by Evan Teters on 10/29/18.
//  Copyright © 2018 Evan Teters. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    @IBOutlet weak var excuseTextLabel: UILabel!
    
    var excuseLocation:String = ""
    var currentArticle: NYTDocument?
    var allArticles: [NYTDocument]?
    var numberArticle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentResult = Model.sharedInstance.currentResponse,
            currentResult.status == "OK" else {
            return
        }
        self.allArticles = currentResult.response.docs
        numberArticle = Int.random(in: 0 ..< allArticles!.count)
        changeExcuse(num: numberArticle)
        
    }
    @IBAction func giveMeAnotherWasPressed(_ sender: Any) {
        numberArticle = numberArticle + 1
        changeExcuse(num: (numberArticle) % (allArticles?.count)!)
    }
    
    func changeExcuse(num:Int) {
        self.currentArticle = allArticles?[num]
        let snippet = currentArticle?.snippet ?? "Oops"
        let array = snippet.split(separator: ".")
        excuseTextLabel.text = "I will be late to " + excuseLocation + " because " + array[0]
    }
    @IBAction func CloseButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
