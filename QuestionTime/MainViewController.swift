//
//  ViewController.swift
//  QuestionTime
//
//  Created by Tyler Jasper on 8/4/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var currentQuestionCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var currentAnswerLabel: UILabel!
    @IBOutlet var showQuestionButton: UIButton!
    @IBOutlet var showAnswerButton: UIButton!
    
    
    let questions: [String] = ["How many U.S. states border Gulf of Mexico?", "What is sushi traditionally wrapped in?", "Name the world's biggest island", "What element begins with the letter K", "What is the diameter of Earth?", "What is the world's longest river?"]
    
    let answers: [String] = ["Five", "Edible seaweed", "Greenland", "Krypton", "8,000 miles", "Amazon"]
    
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showQuestionButton.layer.cornerRadius = 5
        self.showAnswerButton.layer.cornerRadius = 5
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nextQuestionLabel.alpha = 0
    }
    
    @IBAction func showNextQuestion(_ sender: AnyObject) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        currentAnswerLabel.text = "???"
        animateLabelTranstions()
    }
    
    @IBAction func showAnswer(_ sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        currentAnswerLabel.text = answer
    }

    func animateLabelTranstions() {
        self.view.layoutIfNeeded()
        // Animate alpha 
        // and the center x constraints
        let screenWidth = view.frame.width
        self.nextQuestionCenterXConstraint.constant = 0
        self.currentQuestionCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseIn], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            
            self.view.layoutIfNeeded()
            
            }, completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionCenterXConstraint, &self.nextQuestionCenterXConstraint)
                
                self.updateOffScreenLabel()
        })
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionCenterXConstraint.constant = -screenWidth
    }
}

