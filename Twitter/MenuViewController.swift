//
//  MenuViewController.swift
//  Twitter
//
//  Created by Will Gilman on 4/20/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var tweetsNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    
    var mainViewController: MainViewController!
    var profileNavigationController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = twitterColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50.0
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetsNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        
        viewControllers.append(profileNavigationController)
        viewControllers.append(tweetsNavigationController)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        let menuLabels = ["Profile", "Timeline"]
        cell.menuLabel.text = menuLabels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mainViewController.contentViewController = viewControllers[indexPath.row]
    }

}
