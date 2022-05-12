//
//  LikePhotoViewController.swift
//  Sveta's task by Ivan
//
//  Created by mac on 11.05.2022.
//

import UIKit

class LikePhotoViewController: UIViewController {
    
       //MARK: - @IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    

    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var heartLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    @IBOutlet weak var likeButton: UIButton!
    
    
        //MARK: - Properties
    
    var photo: SimplePhoto!

    
        //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
       
        imageView.image = UIImage(named: photo.name)
    
        updateConstraintsForSize(view.bounds.size)
        updateMinZoomScaleForSize(view.bounds.size)
        
    }
    
    override func viewDidLayoutSubviews() {
       
        super.viewDidLayoutSubviews()
        updateConstraintsForSize(view.bounds.size)
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
        //MARK: - @IBActions
    
    
    @IBAction func didTapLikeButton(_ sender: UIButton) {
        
        onLikePhoto()
        
    }
    
    
    
    private func onLikePhoto() {
        photo.isLiked.toggle()
        
        if photo.isLiked == false {
            likeButton.setTitle("Like", for: .normal)
            heartLabel.text = "♡"
            photo.numberOfLikes -= 1
            likeCountLabel.text = "\(photo.numberOfLikes)"
        } else {
            likeButton.setTitle("Dislike", for: .normal)
            photo.numberOfLikes += 1
            heartLabel.text = "❤️"
            likeCountLabel.text = "\(photo.numberOfLikes)"
            
        }
    }
 

}

    //MARK: - ScrollView Methods

extension LikePhotoViewController: UIScrollViewDelegate {
    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return photoImageView
//    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3
        scrollView.zoomScale = minScale
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 4)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
        
    }
    
    
}