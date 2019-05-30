//
//  DetailView.swift
//  CatApp
//
//  Created by Tom Pruimboom on 29/05/2019.
//  Copyright © 2019 Tom Pruimboom. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    
    var photoArray = [Dictionary<String, Any>] ()
    var selectedIndex = 0
    var text = String()
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    func setup() {
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        loadImage()
        loadText()
    }
    
    
    func loadText (){
        RequestManager.getText { (responseText) in
             let thisText = responseText
            self.textView.text = thisText
            print("succes")
        
        }
    }
    
    
    func loadImage (){
        var photosArray = photoArray[selectedIndex]
        let photoString = photosArray["src"] as? Dictionary<String, Any>
        guard let photo = photoString?["small"] as? String else {return}
        guard let cellPhoto = URL(string: photo) else {return}
        imageView.setImageWith(cellPhoto)
    }
    
}
