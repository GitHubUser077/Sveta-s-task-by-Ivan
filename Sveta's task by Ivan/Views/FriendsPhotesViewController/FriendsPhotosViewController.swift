//
//  FriendsPhotoesViewController.swift
//  Sveta's task by Ivan

//  Created by mac on 11.05.2022.
//

import UIKit

class FriendsPhotosViewController: UIViewController {

        //MARK: - @IBOutlets
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
        //MARK: - Dependencies
    
    var user: SimpleUser! {
        didSet {
            usersPhotos = user.photos
        }
    }
    
    var usersPhotos: [SimplePhoto] = []
    
    
        //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(user.name)'s photos"
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        friendsCollectionView.collectionViewLayout = layout
        
        friendsCollectionView.register(FriendsPhotosCollectionViewCell.nib(), forCellWithReuseIdentifier: FriendsPhotosCollectionViewCell.identifier)
        friendsCollectionView.delegate = self
        friendsCollectionView.dataSource = self
    }
    

  

}


    //MARK: - CollectionView Methods

extension FriendsPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photName = usersPhotos[indexPath.row].name
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsPhotosCollectionViewCell.identifier, for: indexPath) as! FriendsPhotosCollectionViewCell
        
        cell.configure(with: photName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Something")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    
}


