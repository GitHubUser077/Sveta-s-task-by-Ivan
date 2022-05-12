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
        
          //MARK: - CollectionViewcell Layout
        let layout = UICollectionViewFlowLayout()

        //Spacing between cells
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-3, height: (view.frame.size.width/3)-3)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        //Spacing Between the edges of the screen
        layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        
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

        let photo = usersPhotos[indexPath.row]
        
        
        let photoViewController = storyboard?.instantiateViewController(withIdentifier: "LikePhotoViewController") as! LikePhotoViewController
        
        photoViewController.photo = photo
        
        navigationController?.pushViewController(photoViewController, animated: true)
    }
    

        
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
//    }
//
    
}


