//
//  ImageCollectionViewCell.swift
//  Lab13
//
//  Created by Diego Martinez Rayme on 11/19/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
   
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}
