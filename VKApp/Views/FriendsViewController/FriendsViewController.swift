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
    
    var activityIndicator = UIActivityIndicatorView()
    
    var meUser = SimpleUser(name: "Ivan", avatarImage: "mountain1", photos: [SimplePhoto(name: "phone1"),SimplePhoto(name: "phone2"),SimplePhoto(name: "phone3")], groups: [], friends: testUsers)
    
//    var simpleUsers = testUsers
    
    var users: [User] = []
    
    var globalUserDictionary = [String:[User]]()
    var globalUserNameLetterTitles = [String]()
    
    

        //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        

        friendsTableView.register(FriendsTableViewCell.nib(), forCellReuseIdentifier: FriendsTableViewCell.identifier)
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
       
        friendsSearchBar.delegate = self
        
       setUpActivityIndicator()
        activityIndicator.startAnimating()
        
        NetworkManager.shared.request(url: API.urlForFriends(), expecting: FriendsResponse.self) { response in
            switch response {
            case .success(let result):
                for user in result.response.users {
                    print("\(user.firstName)")
                }
                DispatchQueue.main.async {
                    self.users = result.response.users
                    self.createUserDictionary()
                    self.friendsTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            case .failure( let error):
                print(error)
            }
        }
        
    }
    
        //MARK: - Private Methods
    
    private func createUserDictionary() {
     
//        print("\(meUser.friends)")

        for user in users {
            let secondLetterIndex = user.fullName.index(user.fullName.startIndex, offsetBy: 1)
            let userNameFirstLetter = String(user.fullName[..<secondLetterIndex])
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
        
        let userNameLetterTitles = [String](globalUserDictionary.keys)
        print("\(userNameLetterTitles)")
        globalUserNameLetterTitles = userNameLetterTitles.sorted(by: { $0 < $1 })
        print("\(globalUserNameLetterTitles)")
        
    }

    private func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.systemBlue
        view.addSubview(activityIndicator)
    }
 

}

    //MARK: - TableView Methods
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return globalUserNameLetterTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return globalUserNameLetterTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dictionaryKey = globalUserNameLetterTitles[section]
        guard let users = globalUserDictionary[dictionaryKey] else { return 0 }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier, for: indexPath) as! FriendsTableViewCell
        
        let dictionaryKey = globalUserNameLetterTitles[indexPath.section]
        
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
        return globalUserNameLetterTitles
    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dictionaryKey = globalUserNameLetterTitles[indexPath.section]
        
        if let users = globalUserDictionary[dictionaryKey] {
            
            let user = users[indexPath.row]
            
            let friendsPhotosViewController = storyboard?.instantiateViewController(withIdentifier: "FriendsPhotosViewController") as! FriendsPhotosViewController
            
            
            friendsPhotosViewController.user = user
            
            navigationController?.pushViewController(friendsPhotosViewController, animated: true)
            
        }
        
        
        
    }
    
        
}

    //MARK: - Search Functionality

extension FriendsViewController: UISearchBarDelegate {
  
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       

        
        if !searchText.isEmpty {
          
            globalUserDictionary = [:]
            globalUserNameLetterTitles = []
            
            for user in  users {
            
            
                if user.fullName.lowercased().contains(searchText.lowercased())  {
                   
                    let secondLetterIndex = user.fullName.index(user.fullName.startIndex, offsetBy: 1)
                    let userNameFirstLetter = String(user.fullName[..<secondLetterIndex])
                    
                    if var innerLoopUserNameArrayThatHasTheSameKey = globalUserDictionary[userNameFirstLetter] {
                        innerLoopUserNameArrayThatHasTheSameKey.append(user)
                        globalUserDictionary[userNameFirstLetter] = innerLoopUserNameArrayThatHasTheSameKey
                    } else {
                        globalUserDictionary[userNameFirstLetter] = [user]
                    }
                    
                }
                
                let userNameLetterTitle = [String](globalUserDictionary.keys)
                globalUserNameLetterTitles = userNameLetterTitle.sorted(by: { $0 < $1 })
            }
            
        } else {
            globalUserDictionary = [:]
            globalUserNameLetterTitles = []
            createUserDictionary()
            friendsTableView.reloadData()
        }
        
        friendsTableView.reloadData()
        
        
    }
    
    
    

}



