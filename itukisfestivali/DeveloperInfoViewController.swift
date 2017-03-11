//
//  DeveloperInfoViewController.swift
//  itukisfestivali
//
//  Created by Efe Helvaci on 10.01.2017.
//  Copyright © 2017 efehelvaci. All rights reserved.
//

import UIKit

class DeveloperInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookButtonClicked(_ sender: Any) {
        let facebookURL = URL(string: "fb://profile/helvaciefe")!
        if UIApplication.shared.canOpenURL(facebookURL) {
            UIApplication.shared.openURL(facebookURL)
        } else {
            UIApplication.shared.openURL(URL(string: "https://www.facebook.com/helvaciefe")!)
        }
    }
    
    @IBAction func linkedinButtonClicked(_ sender: Any) {
        let linkedinURL = URL(string: "linkedin://profile/efe-helvaci-1368b0b4")!
        if UIApplication.shared.canOpenURL(linkedinURL) {
            UIApplication.shared.openURL(linkedinURL)
        } else {
            UIApplication.shared.openURL(URL(string: "https://tr.linkedin.com/in/efe-helvaci-1368b0b4")!)
        }
    }
    
    @IBAction func twitterButtonClicked(_ sender: Any) {
        let twitterURL = URL(string: "twitter:///user?screen_name=efeconirulez")!
        if UIApplication.shared.canOpenURL(twitterURL) {
            UIApplication.shared.openURL(twitterURL)
        } else {
            UIApplication.shared.openURL(URL(string: "https://twitter.com/efeconirulez")!)
        }
    }
    
    @IBAction func emailClicked(_ sender: Any) {
        let email = "efe.459@gmail.com"
        let url = URL(string: "mailto:\(email)")
        
        UIApplication.shared.openURL(url!)
    }
    
    @IBAction func personalWebsiteClicked(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "http://www.efehelvaci.com/")!)
    }
    
    

    @IBAction func thanksButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
