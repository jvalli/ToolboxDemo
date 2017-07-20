//
//  TDCarousel.swift
//  ToolboxDemo
//
//  Created by Jerónimo Valli on 7/19/17.
//  Copyright © 2017 Toolbox. All rights reserved.
//

import Foundation

enum CarouselTypes: String {
    case poster, thumb
}

class TDCarousel: NSObject {
    
    // MARK: - Variables
    
    public var title: String?
    public var type: CarouselTypes?
    public var items: [TDCarouselItem]?
    
    // MARK: - Public methods
    
    public init(dictionary: [String: Any]) {
        
        if let titleValue = dictionary[TDConstants.JsonKeys.title] as? String {
            title = titleValue
        }
        if let typeValue = dictionary[TDConstants.JsonKeys.type] as? String {
            type = CarouselTypes(rawValue: typeValue)
        }
        if let itemsArray = dictionary[TDConstants.JsonKeys.items] as? [[String: String]] {
            items = [TDCarouselItem]()
            for item in itemsArray {
                let carouselItem = TDCarouselItem(dictionary: item)
                items?.append(carouselItem)
            }
        }
    }
}
