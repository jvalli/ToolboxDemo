//
//  TDCarouselView.swift
//  ToolboxDemo
//
//  Created by Jerónimo Valli on 7/19/17.
//  Copyright © 2017 Toolbox. All rights reserved.
//

import UIKit

class TDCarouselView: UICollectionViewCell {
    
    // MARK: - Variables
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!
    
    fileprivate var carousel: TDCarousel?
    
    public var handlerCarouselItemClicked: ((_ carouselItem: TDCarouselItem) -> Void)?
    
    // MARK: - Life cycle
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - Public functions
    
    public func loadFromCarousel(_ carouselItem: TDCarousel) {
        carousel = carouselItem
        labelTitle.text = carousel?.title
    }
}

// MARK: - UICollectionViewDataSource

extension  TDCarouselView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TDConstants.CarouselCellsIdentifiers.carouselItem, for: indexPath)
        
        if cell is TDCarouselItemView, let carouselItem = carousel?.items?[indexPath.row] {
            (cell as! TDCarouselItemView).loadFromCarouselItem(carouselItem, carouselType: carousel?.type)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = carousel?.items?.count {
            return count
        }
        return 0
    }
}

// MARK: - UICollectionViewDelegate

extension  TDCarouselView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let carouselItem = carousel?.items?[indexPath.row] {
            handlerCarouselItemClicked?(carouselItem)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TDCarouselView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if carousel?.type == .poster {
            return TDConstants.CarouselCellsSizes.poster
        } else if carousel?.type == .thumb {
            return TDConstants.CarouselCellsSizes.thumb
        }
        return CGSize.zero
    }
}
