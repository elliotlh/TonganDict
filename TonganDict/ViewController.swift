//
//  ViewController.swift
//  TonganDict
//
//  Created by Elliot Hanna on 5/9/20.
//  Copyright © 2020 Elliot Hanna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flashCard: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var QA: UILabel!
    @IBOutlet weak var result: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        QA.text = ""
        result.text = ""
    }
    
    func changeSearchPlaceholderColor() {
        let searchField = searchBar.value(forKey: "searchField") as? UITextField
        searchField?.textColor = UIColor.white
        let placeholderLabel = searchField?.value(forKey: "placeholderLabel") as? UILabel
        placeholderLabel?.textColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeSearchPlaceholderColor()
    }
    
    
    @IBAction func flipCard(_ gesture: UITapGestureRecognizer) {
        if flashCard.backgroundColor !== UIColor.red {
            flashCard.backgroundColor = UIColor.red
        } else {
            flashCard.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func needsReview(_ gesture: UISwipeGestureRecognizer) {
        print("NEEDS REVIEW")
    }
    
    @IBAction func gotItCorrect(_ gesture: UISwipeGestureRecognizer) {
        print("GOT IT CORRECT")
    }
}
