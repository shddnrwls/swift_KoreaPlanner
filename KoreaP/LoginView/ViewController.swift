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
    
    var arrayOfImage = ["2", "3"]
    var arrayOfTitle = ["CREATE ACCOUNT", "CREATE THE PLANET"]
    var arrayOfDescription = ["회원가입을 하고 친구들과 같이 여행계획을 공유해보세요!",
                              "지도에 마커를 찍어가면서 자신만의 여행루트와 계획을 작성해보세요!"]
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

