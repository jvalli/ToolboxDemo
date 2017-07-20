//
//  TDConstants.swift
//  ToolboxDemo
//
//  Created by Jerónimo Valli on 7/19/17.
//  Copyright © 2017 Toolbox. All rights reserved.
//

import Foundation
import UIKit

class TDConstants {
    
    public struct FileTypes {
        public static let json = "json"
    }
    
    public struct JsonFiles {
        public static let carousels = "carousels"
    }
    
    public struct JsonKeys {
        public static let title = "title"
        public static let type = "type"
        public static let items = "items"
        public static let url = "url"
        public static let video = "video"
    }
    
    public struct CarouselCellsIdentifiers {
        public static let carousel = "TDCarouselView"
        public static let carouselItem = "TDCarouselItemView"
    }
    
    public struct CarouselCellsSizes {
        public static let poster = CGSize(width: 120, height: 180)
        public static let thumb = CGSize(width: 160, height: 120)
        public static let carouselTitleHeight: CGFloat = 50
    }
}
