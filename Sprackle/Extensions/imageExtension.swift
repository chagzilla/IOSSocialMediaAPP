//
//  imageExtension.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/24/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import Foundation
import FirebaseStorage
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func getProfilePicFromFireBase(location: String) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: location as NSString) as?
            UIImage {
            self.image = cachedImage
            return
        } else {
            let profilepic = Storage.storage().reference().child(location)
            profilepic.getData(maxSize: 20 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                    self.image = UIImage(named: "NoProfilePic")
                }
                else
                {
                    DispatchQueue.main.async {
                        if let downloadedImage = UIImage(data: data!)
                        {
                            imageCache.setObject(downloadedImage, forKey: location as NSString)
                            self.image = UIImage(data: data!)
                        }
                        
                    }
                    
                }
            }
        }
        
        
    }
    
}
