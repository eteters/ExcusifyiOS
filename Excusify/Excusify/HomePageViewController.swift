//
//  HomePageViewController.swift
//  Excusify
//
//  Created by Evan Teters on 10/29/18.
//  Copyright © 2018 Evan Teters. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    @IBOutlet weak var excuseEventTextField: UITextField!
    @IBOutlet weak var excuseReasonTextField: UITextField!
    let activity = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func excusifyButtonPressed(_ sender: Any) {
        view.addSubview(activity)
        activity.startAnimating()
        guard let searchText = excuseReasonTextField.text else {
            return
        }
        
        Model.sharedInstance.NYTSearchApiCall(dispatchQueueForHandler: DispatchQueue.main, searchTerm: searchText) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.activity.stopAnimating()
                self.activity.removeFromSuperview()
                self.present(alert, animated: true)
            }
            
            self.activity.stopAnimating()
            self.activity.removeFromSuperview()
            self.performSegue(withIdentifier: "searchSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let excuseEvent = excuseEventTextField.text ?? "Something"

        if let destination = segue.destination as? SearchResultsViewController{
            destination.excuseLocation = excuseEvent
        }
    }
}
