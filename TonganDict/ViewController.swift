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
    @IBOutlet weak var cardParentView: UIView!
    @IBOutlet weak var answerCard: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var result: UILabel!
    
    private var showingQuestion = true
    private var count = 0
    private let MARGIN_OFFSET = CGFloat(25)
    private let SCREEN_WIDTH = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = "Initial"
        answer.text = String(count)
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
        if showingQuestion {
            UIView.transition(from: questionCard, to: answerCard, duration: 1, options: [UIView.AnimationOptions.transitionFlipFromRight, UIView.AnimationOptions.showHideTransitionViews], completion: nil)
            showingQuestion = false
        } else {
            UIView.transition(from: answerCard, to: questionCard, duration: 1, options: [UIView.AnimationOptions.transitionFlipFromRight, UIView.AnimationOptions.showHideTransitionViews], completion: nil)
            showingQuestion = true
        }
    }
    
    
    @IBAction func flipCard(_ gesture: UITapGestureRecognizer) {
        flipCardAnimation()
        if showingQuestion {
            question.text = String(count)
        } else {
            answer.text = String(count)
        }
        count += 1
    }
    
    @IBAction func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
        manageStateChange(cardView: cardView, sender: sender)
    }
    
    func resetCard(done: Bool) -> Void {
        cardParentView.center.x = self.view.center.x
    }
    
    func manageStateChange(cardView: UIView, sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            if cardView.center.x >= SCREEN_WIDTH - MARGIN_OFFSET {
                UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    cardView.center = CGPoint(x: cardView.center.x + self.SCREEN_WIDTH, y: cardView.center.y)
                }, completion: resetCard)
            } else if cardView.center.x < MARGIN_OFFSET {
                UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    cardView.center = CGPoint(x: cardView.center.x - self.SCREEN_WIDTH, y: cardView.center.y)
                }, completion: resetCard)
            } else {
                UIView.animate(withDuration: 0.2, animations: {cardView.center = self.view.center})
            }
        }
    }
}
