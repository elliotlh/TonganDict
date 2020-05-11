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
    private var previousXCord = CGFloat(25)
    private var count = 0
    private let MARGIN_OFFSET = CGFloat(25)
    private let SCREEN_WIDTH = UIScreen.main.bounds.width
    private let BASE_BACKGROUND_COLOR = UIColor(red: 0.1499227494, green: 0.7227386218, blue: 1.0, alpha: 1.0)
    private let CORRECT_COLOR = UIColor(red: 0.1373, green: 1, blue: 0.5255, alpha: 1.0) /* #23ff86 */
    private let NEEDS_WORK_COLOR = UIColor(red: 1, green: 0.7529, blue: 0.1373, alpha: 1.0) /* #ffc023 */

    override func viewDidLoad() {
        super.viewDidLoad()
        question.text = "Initial"
        answer.text = String(count)
        result.text = ""
        previousXCord = self.view.center.x
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
            UIView.transition(from: questionCard, to: answerCard, duration: 0.75, options: [UIView.AnimationOptions.transitionFlipFromRight, UIView.AnimationOptions.showHideTransitionViews], completion: nil)
            showingQuestion = false
        } else {
            UIView.transition(from: answerCard, to: questionCard, duration: 0.75, options: [UIView.AnimationOptions.transitionFlipFromLeft, UIView.AnimationOptions.showHideTransitionViews], completion: nil)
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
        cardParentView.center = self.view.center
    }
    
    func manageStateChange(cardView: UIView, sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            manageEndState(cardView: cardView)
        } else if sender.state == .changed {
            manageChangedState(cardView: cardView)
        }
    }
    
//    func getBackgroundColor() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
//        var red = CGFloat(0)
//        var green = CGFloat(0)
//        var blue = CGFloat(0)
//        var alpha = CGFloat(0)
//        self.view.backgroundColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//        return (red, green, blue, alpha)
//    }
    
    func generatePercentComplete(cardView: UIView) -> CGFloat {
        let distFromCenter = abs(self.view.center.x - cardView.center.x)
        if distFromCenter > MARGIN_OFFSET {
            return CGFloat(1)
        }
        return CGFloat(distFromCenter / MARGIN_OFFSET)
    }
    
    func fadeToColor() {
        
    }
    
    func movingTowardsCorrectColor(xCord: CGFloat) -> Bool {
        return (xCord > previousXCord && xCord > self.view.center.x)
    }
    
    func movingTowardsBaseColor(xCord: CGFloat) -> Bool {
        return (xCord > previousXCord && xCord < self.view.center.x) || (xCord < previousXCord && xCord > self.view.center.x)
    }
    
    func movingTowardsNeedsWorkColor(xCord: CGFloat) -> Bool {
        return (xCord < previousXCord && xCord < self.view.center.x)
    }
    
    func manageChangedState(cardView: UIView) {
        let XCord = cardView.center.x
        if movingTowardsBaseColor(xCord: XCord) {
            let toColor = BASE_BACKGROUND_COLOR
        } else if movingTowardsCorrectColor(xCord: XCord) {
            let toColor = CORRECT_COLOR
        } else {
            let toColor = NEEDS_WORK_COLOR
        }
        previousXCord = cardView.center.x
    }
    
    func manageEndState(cardView: UIView) {
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
