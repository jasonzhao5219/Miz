//
//  ScaleSegue.swift
//  miz_test
//
//  Created by Jason Zhao on 3/1/20.
//  Copyright © 2020 Jason Zhao. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue{
    
    override func perform() {
        scale()
    }
    
    func scale (){
        
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0, y: 0)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.6, delay: 0, options:  .curveEaseInOut, animations:{ toViewController.view.transform = CGAffineTransform.identity}, completion: {
            success in
            fromViewController.present(toViewController, animated: false, completion: nil)
        })
    }
    
}

class UnwindScaleSegue:UIStoryboardSegue{
    override func perform() {
        scale()
    }
    
    func scale (){
        let toViewController = self.destination
        let fromViewController = self.source
        
        fromViewController.view.superview?.insertSubview(toViewController.view, at: 0)
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0, options:  .curveEaseInOut, animations:{ fromViewController.view.transform = CGAffineTransform(scaleX: 0, y: 0)}, completion: {
            success in
            fromViewController.dismiss(animated: true, completion: nil)
        })
        
    }
    
    
}
