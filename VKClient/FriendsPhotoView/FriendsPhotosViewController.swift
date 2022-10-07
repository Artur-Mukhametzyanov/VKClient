//
//  FriendsPhotosViewController.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 04.12.2021.
//

import UIKit

class FriendsPhotosViewController: UIViewController {
    
    //MARK: - Variables
    var photoCount = 0
    var swipeRight: UIViewPropertyAnimator!
    var swipeLeft: UIViewPropertyAnimator!
    var userId: Int?
    var photoArray: [UIImage] = []
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var centerCarouselPhoto: UIImageView!
    @IBOutlet weak var leftCarouselPhoto: UIImageView!
    @IBOutlet weak var rightCarouselPhoto: UIImageView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let photosInteractor = FriendsPhotosInteractor()
        guard let id = userId else { return }
        photosInteractor.requestFriendsPhotos(ownerId: id) {[weak self] photosArray in
            self?.photoArray = photosArray
            self?.collectionView.reloadData()
            self?.carouselAnimation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.subviews.forEach({ $0.removeFromSuperview() })
    }
}

extension FriendsPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as? FriendsPhotoCell else { return UICollectionViewCell() }
        
        cell.friendsPhotoImage.image = photoArray[indexPath.row]
        
        return cell
    }
}

extension FriendsPhotosViewController {

    //MARK: - Carousel Animation
    func carouselAnimation() {
        setImage()

        let gestPan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        centerCarouselPhoto.addGestureRecognizer(gestPan)

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: { [unowned self] in
            self.centerCarouselPhoto.transform = .identity
            self.leftCarouselPhoto.transform = .identity
            self.rightCarouselPhoto.transform = .identity
        })
    }

    func setImage() {
        var leftPhotoIndex = photoCount - 1
        let centerPhotoIndex = photoCount
        var rightPhotoIndex = photoCount + 1

        if leftPhotoIndex < 0 {
            leftPhotoIndex = photoArray.count - 1
        }

        if rightPhotoIndex > photoArray.count - 1 {
            rightPhotoIndex = 0
        }

        leftCarouselPhoto.image = photoArray[leftPhotoIndex]
        centerCarouselPhoto.image = photoArray[centerPhotoIndex]
        rightCarouselPhoto.image = photoArray[rightPhotoIndex]

        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        leftCarouselPhoto.transform = scale
        centerCarouselPhoto.transform = scale
        rightCarouselPhoto.transform = scale
    }

    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:

            swipeRight = UIViewPropertyAnimator(duration: 0.5,
                                                curve: .easeInOut,
                                                animations: { self.swipeRightAnimation() })

            swipeLeft = UIViewPropertyAnimator(duration: 0.5,
                                               curve: .easeInOut,
                                               animations: { self.swipeLeftAnimation() })

        case .changed:
            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeRight.fractionComplete = abs(translationX)/100
            } else {
                swipeLeft.fractionComplete = abs(translationX)/100
            }
        case.ended:
            swipeRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            swipeLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            return
        }
    }

    func swipeLeftAnimation() {
        UIView.animate(withDuration: 0.01,
                        delay: 0,
                        options: [],
                        animations: { [unowned self] in
            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
            let translation = CGAffineTransform(translationX: -self.view.bounds.maxX + 60, y: 0)
            let transform = scale.concatenating(translation)
            centerCarouselPhoto.transform = transform
            leftCarouselPhoto.transform = transform
            rightCarouselPhoto.transform = transform
        },
                        completion: {[unowned self] _ in
            self.photoCount += 1
            if self.photoCount > self.photoArray.count - 1 {
                self.photoCount = 0
            }
            self.carouselAnimation()
        })
    }

    func swipeRightAnimation() {
        UIView.animate(withDuration: 0.01,
                        delay: 0,
                        options: [],
                        animations: { [unowned self] in
            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
            let translation = CGAffineTransform(translationX: self.view.bounds.maxX - 60, y: 0)
            let transform = scale.concatenating(translation)
            centerCarouselPhoto.transform = transform
            leftCarouselPhoto.transform = transform
            rightCarouselPhoto.transform = transform
        },
                        completion: {[unowned self] _ in
            self.photoCount -= 1
            if self.photoCount < 0 {
                self.photoCount = self.photoArray.count - 1
            }
            self.carouselAnimation()
        })
    }
}

