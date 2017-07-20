//
//  TDHomeController.swift
//  ToolboxDemo
//
//  Created by Jerónimo Valli on 7/19/17.
//  Copyright © 2017 Toolbox. All rights reserved.
//

import Foundation

class TDHomeController: NSObject {
    
    // MARK: - Variables
    
    fileprivate var carousels: [TDCarousel]?
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        
        loadCarouselsFromBundle()
    }
    
    // MARK: - Private methods
    
    fileprivate func loadCarouselsFromBundle() {
        if let path = Bundle.main.path(forResource: TDConstants.JsonFiles.carousels, ofType: TDConstants.FileTypes.json) {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]]
                if jsonResult != nil {
                    carousels = [TDCarousel]()
                    for carousel in jsonResult! {
                        let newCarousel = TDCarousel(dictionary: carousel)
                        carousels?.append(newCarousel)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Public methods

    public func getCarousels() -> [TDCarousel]? {
        return carousels
    }
}
