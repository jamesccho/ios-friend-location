//
//  FriendListViewController.swift
//  FriendLocationSample
//
//  Created by James Chan on 4/4/2018.
//  Copyright © 2018 James Chan. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import AlamofireImage

class FriendListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let jsonUrl = "http://www.json-generator.com/api/json/get/cfdlYqzrfS"
    let jsonStorgeKey = "friends"
    let cellReuseId = "friendCell"
    
    var friendList: [Friend] = []
    var friendListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "All Friends"
    
        friendListTableView = UITableView(frame: self.view.frame, style: .plain)
        friendListTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        friendListTableView.register(FriendTableViewCell.self, forCellReuseIdentifier: cellReuseId)
        friendListTableView.dataSource = self
        friendListTableView.delegate = self
        friendListTableView.estimatedRowHeight = 66
        friendListTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(friendListTableView)

        tryLoadFromStorage()
        
    }
    
    func tryLoadFromStorage() {

        if let friends = try? storage?.object(ofType: [Friend].self, forKey: jsonStorgeKey) {
            updateTableView(friends!)
        }
        // try to load from remote simultaneously
        loadJSONFeed()
    }
    
    func saveFriendsToStorage(_ friends: [Friend]) {
        
        self.storage?.async.setObject(friends, forKey: jsonStorgeKey) { result in
            switch result {
            case .value:
                print("saved successfully")
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    func loadJSONFeed() {
        showIndicator()
        
        var urlRequest = URLRequest(url: URL(string: jsonUrl)!)
        urlRequest.timeoutInterval = 5
        Alamofire.request(urlRequest).validate().response { response in
            
            if let data = response.data {
                if let friends = try? JSONDecoder.decode(data, to: [Friend].self) {
                    
                    //TODO: testing with ramdom color picture
//                    for i in friends.indices {
//                        friends[i].picture = "http://via.placeholder.com/32/" + self.getRandomColor()
//                    }

                    self.updateTableView(friends)
                    
                    self.saveFriendsToStorage(friends)
                }
            }
            self.hideIndicator()
        }
    }
    
    func updateTableView(_ friends: [Friend]) {
        self.friendList.removeAll()
        self.friendList.append(contentsOf: friends)
        self.friendListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let f = friendList[indexPath.row];
        
        let mapController = MapViewController(friend: f)
        
        self.navigationController?.pushViewController(mapController, animated: true)
//        print("Num: \(indexPath.row)")
//        
//        print("Value: \(f.latitude), \(f.longitude)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath as IndexPath) as! FriendTableViewCell
        let f = friendList[indexPath.row];
        cell.name.text = f.name
        cell.icon.af_setImage(withURL: URL(string: f.picture)!, placeholderImage: UIImage(color: UIColor.lightGray))
        
        return cell
    }
    
    func getRandomColor() -> String {
        
        let r:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let g:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let b:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"%06x", rgb)
    }
    
}

