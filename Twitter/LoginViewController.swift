//
//  LoginViewController.swift
//  Twitter
//
//  Created by Will Gilman on 4/12/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onLoginButtonTapped(_ sender: Any) {
        
        TwitterClient.sharedInstance?.login(success: {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            
            let mainViewController = segue.destination as! MainViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            let profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
            mainViewController.contentViewController = profileNavigationController
            menuViewController.profileNavigationController = profileNavigationController
            mainViewController.menuViewController = menuViewController
            menuViewController.mainViewController = mainViewController
        }
    }
}
