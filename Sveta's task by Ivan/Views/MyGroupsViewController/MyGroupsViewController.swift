//
//  MyGroupsViewController.swift
//  Sveta's task by Ivan
//
//  Created by mac on 13.05.2022.
//

import UIKit

class MyGroupsViewController: UIViewController {

        //MARK: - @IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var groupTableView: UITableView!
    
        //MARK: - Properties
//    var user: SimpleUser = SimpleUser(name: "Ivan", avatarImage: "user1", photos: [], groups: simpleGroupTestData)
    
    
    var meUser = SimpleUser(name: "Ivan", avatarImage: "mountain1", photos: [SimplePhoto(name: "phone1"),SimplePhoto(name: "phone2"),SimplePhoto(name: "phone3")], groups: [SimpleGroup(name: "hoho", photos: [SimplePhoto(name: "cat1")], thumbnailPhoto: SimplePhoto(name: "cat3"), groupDescriptionText: "gjgj", isSubscribedToUser: true, users: [])], friends: testUsers) {
        didSet {
            print("is set !!!!!!!!!!")
            filteredGroupsDictionary = [:]
            createGroupDictionaryAndTitles()
        }
    }
    
    private var filteredGroupsDictionary = [String:[SimpleGroup]]()
    private var filteredGroupNameLetterTitles = [String]()
    
    
//    var myGroups:[SimpleGroup] = simpleGroupTestData
    
    
        //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        groupTableView.register(MyGroupTableViewCell.nib(), forCellReuseIdentifier: MyGroupTableViewCell.identifier)
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        
        createGroupDictionaryAndTitles()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Croups", style: .done, target: self, action: #selector(didTapGroupsBarButtonItem))
        
    }
    
    
    
        //MARK: - Private Methods
    
    private func createGroupDictionaryAndTitles() {
        for group in meUser.groups {
            let secondLetterIndex = group.name.index(group.name.startIndex, offsetBy: 1)
            let firstLetter = String(group.name[..<secondLetterIndex])
            
            if var innerGroupArray = filteredGroupsDictionary[firstLetter] {
                innerGroupArray.append(group)
                filteredGroupsDictionary[firstLetter] = innerGroupArray
            } else {
                filteredGroupsDictionary[firstLetter] = [group]
            }
            
            let allTitles = [String](filteredGroupsDictionary.keys)
            filteredGroupNameLetterTitles = allTitles.sorted(by: { $0 < $1 })
        }
    }
    
    
        //MARK: - Navigation
    @objc func didTapGroupsBarButtonItem() {
        
        let subscribeToGroupsVC = storyboard?.instantiateViewController(withIdentifier: "SubscribeGroupViewController") as! SubscribeGroupViewController
        
        subscribeToGroupsVC.title = "Groups"
        subscribeToGroupsVC.meUser = meUser
        
        
        subscribeToGroupsVC.completionHandler = { [weak self] returnedUser in
           
            self?.meUser = returnedUser
           
            DispatchQueue.main.async {
                self?.groupTableView.reloadData()
            }
        }
        
        navigationController?.pushViewController(subscribeToGroupsVC, animated: true)
    }

  

}

    //MARK: - TableView Extensions

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredGroupNameLetterTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredGroupNameLetterTitles[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dictionaryKey = filteredGroupNameLetterTitles[section]
        guard let users = filteredGroupsDictionary[dictionaryKey] else { return 0}
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyGroupTableViewCell.identifier, for: indexPath) as! MyGroupTableViewCell
        
        let dictionaryKey = filteredGroupNameLetterTitles[indexPath.section]
        
        if let usersArray = filteredGroupsDictionary[dictionaryKey] {
            
            cell.configure(with: usersArray[indexPath.row])
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
    
  
    
    // Fixing separator issues
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        // I Had some issue with the separator getting cut of partially by the image
        // this somehow fixed it
        cell.separatorInset = .zero


    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return filteredGroupNameLetterTitles
    }
    
    
}
