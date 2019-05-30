//
//  GifDetailViewController.swift
//  CatApp
//
//  Created by Tom Pruimboom on 30/05/2019.
//  Copyright © 2019 Tom Pruimboom. All rights reserved.
//

import Foundation
import UIKit
import SwiftyGif

class GifDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var currentImage = String()
    var selectedIndex = 0
    var photoArray = [Dictionary<String, Any>] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    func setup (){
        imageView.backgroundColor = .white
        setImage()
    }
    
    
    func setImage() {
        var photosArray = photoArray[selectedIndex]
        guard let thisArray = photosArray["url"] as? String else {return}
        guard let url = URL(string: thisArray) else {return}
        imageView.setGifFromURL(url)
    }
}
