//
//  ViewController.swift
//  TonganDict
//
//  Created by Elliot Hanna on 5/9/20.
//  Copyright © 2020 Elliot Hanna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionCard: UIView!
    @IBOutlet weak var answerCard: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var result: UILabel!
    
    private var showingFront = true

    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = "Front"
        answer.text = "Back"
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
    
    func flipCardAnimation() {
        UIView.transition(from: questionCard, to: answerCard, duration: 1, options: [UIView.AnimationOptions.transitionFlipFromRight, UIView.AnimationOptions.showHideTransitionViews], completion: nil)
//        if showingFront {
//            UIView.transition(from: questionCard, to: answerCard, duration: 1, options: UIView.AnimationOptions.transitionFlipFromRight, completion: nil)
//        } else {
//            UIView.transition(from: answerCard, to: questionCard, duration: 1, options: UIView.AnimationOptions.transitionFlipFromRight, completion: nil)
//        }
    }
    
    
    @IBAction func flipCard(_ gesture: UITapGestureRecognizer) {
//        if showingFront {
//            questionCard.backgroundColor = UIColor.red
//            answerCard.backgroundColor = UIColor.red
//            question.text = "HAHA"
//            answer.text = "HAHA!"
//            showingFront = false
//        } else {
//            questionCard.backgroundColor = UIColor.white
//            answerCard.backgroundColor = UIColor.white
//            question.text = "BOO"
//            answer.text = "BOOO!"
//            showingFront = true
//        }
        flipCardAnimation()
    }
    
    @IBAction func needsReview(_ gesture: UISwipeGestureRecognizer) {
        result.text = "Needs review"
    }
    
    @IBAction func gotItCorrect(_ gesture: UISwipeGestureRecognizer) {
        result.text = "Got it correct"
    }
}
