//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Will Gilman on 4/19/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var profileView: ProfileView!
    
    var tweets: [Tweet]!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user == nil {
            user = User.currentUser
        }
        
        profileView.user = user

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Configure navigation bar.
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = twitterColor
            navigationBar.tintColor = UIColor.white
            navigationBar.titleTextAttributes = [
                NSFontAttributeName : UIFont.boldSystemFont(ofSize: 22),
                NSForegroundColorAttributeName : UIColor.white
            ]
        }
        
        TwitterClient.sharedInstance?.statuses(id: user.id!, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }


}
