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
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    var currentImage = String()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       

    }
    func setup (){
        backButton.title = "back"
        imageView.backgroundColor = .lightGray
        setImage()
        
    }
    
    func setImage() {
        guard let url = URL(string: currentImage) else {return}
        imageView.setGifFromURL(url)
        
    }
}
