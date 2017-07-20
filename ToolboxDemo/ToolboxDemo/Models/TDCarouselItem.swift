//
//  TDCarouselItem.swift
//  ToolboxDemo
//
//  Created by Jerónimo Valli on 7/19/17.
//  Copyright © 2017 Toolbox. All rights reserved.
//

import Foundation

class TDCarouselItem: NSObject {
    
    // MARK: - Variables
    
    public var title: String?
    public var url: String?
    public var video: String?
    
    // MARK: - Public methods
    
    public init(dictionary: [String: String]) {
        
        if let titleValue = dictionary[TDConstants.JsonKeys.title] {
            title = titleValue
        }
        if let urlValue = dictionary[TDConstants.JsonKeys.url] {
            url = urlValue
        }
        if let videoValue = dictionary[TDConstants.JsonKeys.video] {
            video = videoValue
        }
    }
}
