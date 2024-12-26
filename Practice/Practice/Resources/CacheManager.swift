//
//  CacheManager.swift
//  Practice
//
//  Created by Vishal Manhas on 28/11/24.
//

import Foundation
import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 2024 * 2024
        return cache
    }()

    func getCachedImage(_ key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }

    func cacheImage(_ key: String, image: UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
    }

    func removeImageFromCache(_ key: String) {
        imageCache.removeObject(forKey: key as NSString)
    }
    
    func clearCache() {
        
        imageCache.removeAllObjects()
    }
    
    func loadImage(urlString:String) async   -> UIImage{
             
        guard let url = URL(string: urlString) else { return  UIImage()}
        
         var cashedImage:UIImage?
        if let cached = ImageCache.shared.getCachedImage(urlString) {
            cashedImage =  cached
            print(" Getting From the cashe system")
        } else {
           
                do {
                    let (data, _) = try   await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        ImageCache.shared.cacheImage(urlString, image: image)
                        print("added in the cashe")
                        return image
                    }
                    
                } catch {
                    print("Failed to load image from \(url): \(error)")
                }
            
        }
         return cashedImage ?? UIImage()
    }
    
}

