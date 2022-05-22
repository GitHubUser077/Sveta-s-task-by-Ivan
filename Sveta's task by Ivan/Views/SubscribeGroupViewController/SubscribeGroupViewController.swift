//
//  SubscribeGroupViewController.swift
//  Sveta's task by Ivan
//
//  Created by mac on 13.05.2022.
//

import UIKit

class SubscribeGroupViewController: UIViewController {
    
    @IBOutlet weak var groupSearchBar: UISearchBar!
    @IBOutlet weak var groupTableView: UITableView!
    
    
    
    
    //MARK: - Dependencies
    var meUser: SimpleUser!
    
    //MARK: - Properties
    
    
    var completionHandler: ((SimpleUser) -> ())?
    
    
    var filteredDictionaryOfGroups: [String:[SimpleGroup]] = [:]
    var filteredTitleLetters: [String] = []
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
        groupTableView.register(SubscribeGroupsTableViewCell.nib(), forCellReuseIdentifier: SubscribeGroupsTableViewCell.identifier)
        
        
        setUpDictionaryAndTitles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completionHandler?(meUser)
    }
    
    //MARK: - Private Methods
    
    private func setUpDictionaryAndTitles() {
        for group in simpleGroupTestData {
            let secondLetterIndex = group.name.index(group.name.startIndex, offsetBy: 1)
            let firstLetter = String(group.name[..<secondLetterIndex])
            if var innerGroupArray = filteredDictionaryOfGroups[firstLetter] {
                innerGroupArray.append(group)
                filteredDictionaryOfGroups[firstLetter] = innerGroupArray
            } else {
                filteredDictionaryOfGroups[firstLetter] = [group]
            }
            
            let allTitles = [String](filteredDictionaryOfGroups.keys)
            filteredTitleLetters = allTitles.sorted(by: { $0 < $1 })
        }
    }
    
    
    private func AddOrRemoveGroupToOrFromUser(user: SimpleUser, group: SimpleGroup) {
        
        
        
        
        
    }
    
    
    
}

//MARK: - TableView Methods

extension SubscribeGroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredTitleLetters.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredTitleLetters[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dictionaryKey = filteredTitleLetters[section]
        guard let groups = filteredDictionaryOfGroups[dictionaryKey] else { return 0 }
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SubscribeGroupsTableViewCell.identifier, for: indexPath) as! SubscribeGroupsTableViewCell
        
        
        let dictionaryKey = filteredTitleLetters[indexPath.section]
        
        if let groups = filteredDictionaryOfGroups[dictionaryKey]  {
            cell.cellGroup = groups[indexPath.row]
            cell.userId = meUser.id
            cell.configure(with: groups[indexPath.row])
            cell.delegate = self
        }
        
        
        
        return cell
    }
    
    
    
}


//MARK: - Protocols

extension SubscribeGroupViewController: SubscribeGroupsTableViewCellProtocol {
    
    func onButtonTap(sender: SubscribeGroupsTableViewCell) {
        
        guard let group = sender.cellGroup else { return }
        
        if let groupIndex = simpleGroupTestData.firstIndex(where: { $0.id == group.id }) {
            if meUser.groups.contains(where: { $0.id == group.id })
                &&
                simpleGroupTestData[groupIndex].users.contains(where: { $0.id == meUser.id}) {
                
                meUser.groups.removeAll(where: { $0.id == group.id})
                simpleGroupTestData[groupIndex].users.removeAll(where: { $0.id == meUser.id })
                
            } else {
                meUser.groups.append(group)
                simpleGroupTestData[groupIndex].users.append(meUser)
            }
        }

        filteredDictionaryOfGroups = [:]
        setUpDictionaryAndTitles()
        groupTableView.reloadData()
        
    }
    
    
}



