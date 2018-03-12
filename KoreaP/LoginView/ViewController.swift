//
//  ViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 11..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import AlertOnboarding


class ViewController: UIViewController,AlertOnboardingDelegate{
    var alertView: AlertOnboarding!
    
    var arrayOfImage = ["1", "2", "3"]
    var arrayOfTitle = ["CREATE ACCOUNT", "CHOOSE THE PLANET", "DEPARTURE"]
    var arrayOfDescription = ["In your profile, you can view the statistics of its operations and the recommandations of friends",
                              "Purchase tickets on hot tours to your favorite planet and fly to the most comfortable intergalactic spaceships of best companies",
                              "In the process of flight you will be in cryogenic sleep and supply the body with all the necessary things for life"]
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView = AlertOnboarding(arrayOfImage: arrayOfImage, arrayOfTitle: arrayOfTitle, arrayOfDescription: arrayOfDescription)
        alertView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startBtn(_ sender: AnyObject) {
        self.alertView.show()
    }
    func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int) {
        print("Onboarding skipped the \(currentStep) step and the max step he saw was the number \(maxStep)")
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "loginView") // 1
        uvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve // 2
        self.present(uvc, animated: true)
    }
    
    func alertOnboardingCompleted() {
        print("Onboarding completed!")
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "loginView") // 1
        uvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve // 2
        self.present(uvc, animated: true)
        

    }
    
    func alertOnboardingNext(_ nextStep: Int) {
        print("Next step triggered! \(nextStep)")
    }


}

