//
//  MenuViewController.swift
//  FlyRight
//
//  Created by Jacob Patel on 8/1/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {
    var scene: GameScene!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        // Present the scene.
        skView.presentScene(scene)
    }
    
    }


