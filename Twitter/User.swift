//
//  User.swift
//  Twitter
//
//  Created by Will Gilman on 4/12/17.
//  Copyright © 2017 Will Gilman. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: String?
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    var profileBackgroundUrl: URL?
    var followersCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    var dictionary: NSDictionary?

    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        id = dictionary["id_str"] as? String
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        let profileBackgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let profileBackgroundUrlString = profileBackgroundUrlString {
            profileBackgroundUrl = URL(string: profileBackgroundUrlString)
        }
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
            
                if let userData = userData {
                    print("\(userData)")
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
            
        } set(user) {
            
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let userData = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: []) 
                defaults.set(userData, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
    
}
