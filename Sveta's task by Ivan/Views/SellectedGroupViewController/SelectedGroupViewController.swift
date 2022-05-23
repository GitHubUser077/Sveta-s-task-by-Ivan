//
//  SelectedGroupViewController.swift
//  Sveta's task by Ivan
//
//  Created by mac on 22.05.2022.
//

import UIKit

class SelectedGroupViewController: UIViewController {
    
        //MARK: - @IBOutlets
    @IBOutlet weak var sliderGroupCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var textView: UITextView!
    
        //MARK: - Dependencies
    var meUser: SimpleUser!
    var group: SimpleGroup!
    
    
        //MARK: - Properties
    
    var completionHandler: ((SimpleUser) -> ())?
    
    var timer = Timer()
    var counter = 0
    
    var barButtonItem = UIBarButtonItem(title: "0000", style: .done, target: nil, action: #selector(didTapSelectedGroupViewControllerBarButton))
    
        //MARK: - Lifecyle
        override func viewDidLoad() {
        super.viewDidLoad()

            sliderGroupCollectionView.delegate = self
            sliderGroupCollectionView.dataSource = self
           
            
            
            title = group.name
            
            navigationItem.rightBarButtonItem = barButtonItem
            //FIXME: target = self
            //somehow it works only this way if I set self above, it will crash
            barButtonItem.target = self
            
            textView.text = group.groupDescriptionText
            setBarButtonTitle()
            
               // - FlowLayout
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal


            //Spacing between cells
            layout.itemSize = CGSize(width: (view.frame.size.width), height: (view.frame.size.width))
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0

            //Spacing Between the edges of the screen
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

            sliderGroupCollectionView.collectionViewLayout = layout
            
            //PageController
            pageController.numberOfPages = group.photos.count
            pageController.currentPage = 0
            
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
            
        }
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completionHandler?(meUser)
    }
    
    

        //MARK: - Private Methods
    @objc private func didTapSelectedGroupViewControllerBarButton() {
      
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
        
        setBarButtonTitle()
    }

    private func setBarButtonTitle() {
        if meUser.groups.contains(where: { $0.id == group.id }) {
            barButtonItem.title = "Unsubscribe"
            barButtonItem.tintColor = .systemRed
        } else {
            barButtonItem.title = "Subscribe"
            barButtonItem.tintColor = .systemGreen
        }
    }
    
    
    @objc private func changeImage() {
        if counter < group.photos.count {

            let index = IndexPath(row: counter, section: 0)
            sliderGroupCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath(row: counter, section: 0)
            sliderGroupCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageController.currentPage = counter
            counter = 1
        }
    }
    
}

    //MARK: - CollectionView Methods
extension SelectedGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = UIImage(named: group.photos[indexPath.row].name)
        }
        
        
        
        return cell
        
    }
    
    
}

    //MARK: - CollectionView FlowLayout

extension SelectedGroupViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderGroupCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
   
    
}
