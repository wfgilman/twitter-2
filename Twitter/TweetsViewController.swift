//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Will Gilman on 4/12/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewTweetViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure refresh control.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        // Configure table view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80.0
        tableView.insertSubview(refreshControl, at: 0)
        let cell = UINib(nibName: "BaseTweetCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "TweetsTweetCell")
        
        // Configure navigation bar.
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = twitterColor
            navigationBar.tintColor = UIColor.white
            navigationBar.titleTextAttributes = [
                NSFontAttributeName : UIFont.boldSystemFont(ofSize: 22),
                NSForegroundColorAttributeName : UIColor.white
            ]
        }

        makeTwitterRequest()
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    // Delegate methods.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetsTweetCell", for: indexPath) as! BaseTweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showTweetSegue", sender: UITableViewCell.self)
    }
    
    func didTweet(newTweetViewController: NewTweetViewController, tweet: Tweet) {
        tweets.insert(tweet, at: 0)
        tableView.reloadData()
    }
    
    // Segue method.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTweetSegue" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets[indexPath!.row]
        
            let tweetViewController = segue.destination as! TweetViewController
            tweetViewController.tweet = tweet
            
        } else if segue.identifier == "newTweetSegue" {
            
            let navigationController = segue.destination as! UINavigationController
            let newTweetViewController = navigationController.topViewController as! NewTweetViewController
            newTweetViewController.replyToUserScreenName = nil
            newTweetViewController.reply_id = nil
            newTweetViewController.delegate = self
        }
    }
    
    // Helper functions.
    func makeTwitterRequest() {
        TwitterClient.sharedInstance?.homeTimeline(sucess: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print("Error: \(error.localizedDescription)")
        })
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        makeTwitterRequest()
        refreshControl.endRefreshing()
    }

}
