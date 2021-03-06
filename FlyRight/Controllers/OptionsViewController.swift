//
//  OptionsViewController.swift
//  FlyRight
//
//  Created by Jacob Patel on 3/3/18.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//
import UIKit
import SpriteKit
import AVFoundation
import Firebase
import GoogleMobileAds

class OptionsViewController: UIViewController {

    // The scene draws the tiles and space sprites, and handles actions (swipes for CC).
    var scene: OptionsScene!

    // For recognizing gestures.
    var tapGestureRecognizer: UITapGestureRecognizer!

    // MARK: View Controller Functions
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    // To reference music.
    @IBOutlet weak var controlMusic: UISwitch!
    
    // To reference sounds.
    @IBOutlet weak var controlSounds: UISwitch!
    
    @IBAction func controlMusic(_ sender: Any) {
        if ((sender as AnyObject).isOn) {
            UserDefaults.standard.set(true, forKey: "shouldPlay")
            UserDefaults.standard.set(false, forKey: "isPlaying")
            UserDefaults.isFirstLaunchMenu()
            UserDefaults.standard.set(false, forKey: "isPaused")
        } else {
            UserDefaults.standard.set(false, forKey: "shouldPlay")
            UserDefaults.standard.set(false, forKey: "isPlaying")
            UserDefaults.isFirstLaunchMenu()
            UserDefaults.standard.set(true, forKey: "isPaused")
        }
        UserDefaults.standard.set((sender as AnyObject).isOn, forKey: "musicSwitchState")
    }
    
    @IBAction func controlSoundEffects(_ sender: Any) {
        if ((sender as AnyObject).isOn) {
            UserDefaults.standard.set(true, forKey: "shouldMakeSounds")
        } else {
            UserDefaults.standard.set(false, forKey: "shouldMakeSounds")
        }
        UserDefaults.standard.set((sender as AnyObject).isOn, forKey: "soundSwitchState")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

    // Must be touched multiple times to records to original values.
    @IBAction func resetRecords(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "tiles")
        UserDefaults.standard.set(0, forKey: "score")
        UserDefaults.standard.set(0, forKey: "turns")
    }
    
    @IBAction func moveToMenu(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        AVAudioPlayer.playSpecAudio(audioPiece: "Back", volume: 0.7)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
 */
        
        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false

        // Create and configure the scene.
        scene = OptionsScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill

        // Present the scene.
        skView.presentScene(scene)
        
        // Save state of the button.
        controlMusic.isOn =  UserDefaults.standard.bool(forKey: "musicSwitchState")
        controlSounds.isOn = UserDefaults.standard.bool(forKey: "soundSwitchState")

    }
}

