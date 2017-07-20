//
//  TDCarouselItemView.swift
//  ToolboxDemo
//
//  Created by Jerónimo Valli on 7/19/17.
//  Copyright © 2017 Toolbox. All rights reserved.
//

import UIKit


class TDCarouselItemView: UICollectionViewCell {
    
    // MARK: - Variables
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    // MARK: - Public functions
    
    public func loadFromCarouselItem(_ carouselItem: TDCarouselItem, carouselType: CarouselTypes?) {
        
        labelTitle.text = carouselItem.title
        if carouselType == .poster {
            labelTitle.backgroundColor = UIColor.clear
            labelTitle.textColor = UIColor.white
        } else if carouselType == .thumb {
            labelTitle.backgroundColor = UIColor.lightGray
            labelTitle.textColor = UIColor.black
        }
        if let imageUrl = carouselItem.url {
            imageViewPhoto.downloadedFrom(link: imageUrl, handler: nil)
        }
    }
}
