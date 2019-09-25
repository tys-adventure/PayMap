//
//  CardViewExtension.swift
//  Pay?
//
//  Created by Tyler P Admin on 5/18/19.
//  Copyright © 2019 Tyler P Admin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Card Functions
extension ViewController {
    
    func setupCard() {
        
        cardViewController = CardViewController(nibName: "GenresCardViewController", bundle: nil)
        self.addChild(cardViewController)
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        self.mapView.addSubview(cardViewController.view)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognzier:)))
        let panGestureRecognizerHandleArea = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))
        let panGestureRecognizerContentView = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizerHandleArea)
        cardViewController.contentView.addGestureRecognizer(panGestureRecognizerContentView)
    }
    
    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
            
        default:
            break
        }
    }
    
    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                    
                    
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    print("")
                //self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    //self.visualEffectView.effect = nil
                    
                    print("")
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}
