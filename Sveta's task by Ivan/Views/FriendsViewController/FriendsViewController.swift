//
//  FriendsViewController.swift
//  Sveta's task by Ivan
//
//  Created by mac on 07.05.2022.
//

import UIKit

class FriendsViewController: UIViewController {
    
        //MARK: - @IBOutlets
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    @IBOutlet weak var friendsTableView: UITableView!
    
    
        //MARK: - Properties
    
    var simpleUsers = testUsers
    
    var globalUserDictionary = [String:[SimpleUser]]()
    var globalUserNameLetterTitle = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       createUserDictionary()

        friendsTableView.register(FriendsTableViewCell.nib(), forCellReuseIdentifier: FriendsTableViewCell.identifier)
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
       
        
        
    }
    
    private func createUserDictionary() {
        

        for user in simpleUsers {
            let secondLetterIndex = user.name.index(user.name.startIndex, offsetBy: 1)
            let userNameFirstLetter = String(user.name[..<secondLetterIndex])
//            print("\(userNameFirstLetter)")
            
            if var innerLoopUserNameArrayThatHasTheSameKey = globalUserDictionary[userNameFirstLetter] {
//                print("\(innerLoopUserNameArrayThatHasTheSameKey)")
                innerLoopUserNameArrayThatHasTheSameKey.append(user)
                globalUserDictionary[userNameFirstLetter] = innerLoopUserNameArrayThatHasTheSameKey
//                print("\(globalUserDictionary)")
            } else {
                globalUserDictionary[userNameFirstLetter] = [user]
//                print("\(globalUserDictionary)")
            }
        }
        
        let userNameLetterTitle = [String](globalUserDictionary.keys)
        print("\(userNameLetterTitle)")
        globalUserNameLetterTitle = userNameLetterTitle.sorted(by: { $0 < $1 })
        print("\(globalUserNameLetterTitle)")
        
    }

 

}

    //MARK: - TableView Methods
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return globalUserNameLetterTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return globalUserNameLetterTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dictionaryKey = globalUserNameLetterTitle[section]
        guard let users = globalUserDictionary[dictionaryKey] else { return 0 }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier, for: indexPath) as! FriendsTableViewCell
        
        let dictionaryKey = globalUserNameLetterTitle[indexPath.section]
        
        if let usersArray = globalUserDictionary[dictionaryKey] {
            
            
            cell.configure(with: usersArray[indexPath.row])
            
            
//            cell.textLabel?.text = usersArray[indexPath.row].name
//            cell.imageView?.image = UIImage(named: usersArray[indexPath.row].imageName)
        
//            cell.imageView?.layer.cornerRadius = cell.frame.size.height/2
//            cell.imageView?.layer.masksToBounds = true
            

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1)
        headerView.textLabel?.textColor = .systemBlue
        
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 20.0)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return globalUserNameLetterTitle
    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dictionaryKey = globalUserNameLetterTitle[indexPath.section]
        
        if let users = globalUserDictionary[dictionaryKey] {
            
            let user = users[indexPath.row]
            
            let friendsPhotosViewController = storyboard?.instantiateViewController(withIdentifier: "FriendsPhotosViewController") as! FriendsPhotosViewController
            friendsPhotosViewController.user = user
            
            navigationController?.pushViewController(friendsPhotosViewController, animated: true)
            
        }
        
        
        
    }
    
    
}
