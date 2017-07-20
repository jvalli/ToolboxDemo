//
//  TDHomeViewController.swift
//  ToolboxDemo
//
//  Created by Jerónimo Valli on 7/19/17.
//  Copyright © 2017 Toolbox. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TDHomeViewController: UICollectionViewController {

    // MARK: - Constants
    
    fileprivate let homeController = TDHomeController()
    fileprivate let playerViewController = AVPlayerViewController()
    
    // MARK: - Variables
    
    fileprivate var carouselItemSelected: TDCarouselItem?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage.from(color: UIColor.white), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage.from(color: UIColor.white)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView?.collectionViewLayout = layout
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { context in
            self.collectionView?.collectionViewLayout.invalidateLayout()
        }, completion:  { context in
            self.collectionView?.reloadData()
        })
    }
    
    // MARK: - Private functions
    
    fileprivate func presentVideoFromCarouselItem(_ carouselItem: TDCarouselItem) {
        
        if let videoUrl = carouselItem.video, let url = URL(string: videoUrl) {
            let videoPlayer = AVPlayer(url: url)
            playerViewController.player = videoPlayer
            present(playerViewController, animated: true) {
                self.playerViewController.player?.play()
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "El item seleccionado no posee video", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension TDHomeViewController {
        
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = homeController.getCarousels()?.count {
            return count
        }
        return 0
    }
        
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TDConstants.CarouselCellsIdentifiers.carousel, for: indexPath)
        
        if cell is TDCarouselView, let carousel = homeController.getCarousels()?[indexPath.row] {
            (cell as! TDCarouselView).loadFromCarousel(carousel)
            (cell as! TDCarouselView).handlerCarouselItemClicked = { carouselItem in
                self.presentVideoFromCarouselItem(carouselItem)
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TDHomeViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let carousel = homeController.getCarousels()?[indexPath.row] {
            if carousel.type == .poster {
                return CGSize(width: UIScreen.main.bounds.width, height: TDConstants.CarouselCellsSizes.poster.height + TDConstants.CarouselCellsSizes.carouselTitleHeight)
            } else if carousel.type == .thumb {
                return CGSize(width: UIScreen.main.bounds.width, height: TDConstants.CarouselCellsSizes.thumb.height + TDConstants.CarouselCellsSizes.carouselTitleHeight)
            }
        }
        return CGSize.zero
    }
}
