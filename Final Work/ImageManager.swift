//
//  ImageManager.swift
//  Final Work
//
//  Created by Lucas Robaert on 28/08/23.
//

import Foundation
import UIKit

final class ImageManager {
    static let shared = ImageManager()
    
    var cache: NSCache<NSString, UIImage> = .init()
    
    func loadImage(from url: URL?, completion: @escaping (UIImage?) -> Void){
        guard let url = url else {
            completion(nil)
            return
        }
        
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString){
            completion(cachedImage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
        completion(nil)
        return
    }
        self.cache.setObject(image, forKey: url.absoluteString as NSString)
        
            DispatchQueue.main.async {
                completion(image)
            }
    }
        task.resume()
    }
}
