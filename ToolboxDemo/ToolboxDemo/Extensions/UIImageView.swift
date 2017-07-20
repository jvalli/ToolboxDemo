//
//  UIImageView.swift
//  ToolboxDemo
//
//  Created by Jerónimo Valli on 7/19/17.
//  Copyright © 2017 Toolbox. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, handler: ((_ completed: Bool) -> Void)?) {
        contentMode = mode
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        
        session.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    handler?(false)
                    return
            }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
                handler?(true)
            }
        }.resume()
    }
    
    public func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, handler: ((_ completed: Bool) -> Void)?) {
        guard let url = URL(string: link) else {
            handler?(false)
            return
        }
        downloadedFrom(url: url, contentMode: mode, handler: handler)
    }
}
