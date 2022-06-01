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
    
    var user: User! {
        didSet {
//            usersPhotos = user.photos
        }
    }
    
    var usersPhotos: [Photo] = []
    
    
        //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(user.fullName)'s photos"
        
          //MARK: - CollectionViewCell Layout
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
        
        
        
        NetworkManager.shared.request(url: API.urlForPhotos(userId: user.id), expecting: PhotoResponse.self) { response in
            switch response {
            case .success( let result ):
                DispatchQueue.main.async {
                    self.usersPhotos = result.response.photos
                    self.friendsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    

  

}


    //MARK: - CollectionView Methods

extension FriendsPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersPhotos.count
        print("&&&&&&&&&&&&&&&&&&&&&&&&&")
        print("\(usersPhotos.count)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photName = usersPhotos[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsPhotosCollectionViewCell.identifier, for: indexPath) as! FriendsPhotosCollectionViewCell
        
        cell.configure(with: photName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let photo = usersPhotos[indexPath.row]
        
        
        let photoViewController = storyboard?.instantiateViewController(withIdentifier: "LikePhotoViewController") as! LikePhotoViewController
        
        photoViewController.photo = photo
        
        photoViewController.completionHandler = { [weak self] returnedPhoto in
            
            self?.usersPhotos[indexPath.row] = returnedPhoto
            
        }
        
        navigationController?.pushViewController(photoViewController, animated: true)
    }
    

        
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
//    }
//
    
}


