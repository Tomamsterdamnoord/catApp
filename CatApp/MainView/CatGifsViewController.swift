//
//  CatGifsViewController.swift
//  CatApp
//
//  Created by Tom Pruimboom on 30/05/2019.
//  Copyright © 2019 Tom Pruimboom. All rights reserved.
//

import Foundation
import UIKit
import SwiftyGif
import AFNetworking

class CatGifsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var photoArray =  [Dictionary<String, Any>] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup () {
        loadGifs()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CatTableViewCell.NIBFILE, forCellReuseIdentifier: CatTableViewCell.IDENTIFIER)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatTableViewCell", for: indexPath)
        guard let catCell = cell as? CatTableViewCell else {return cell}
        let photosArray = photoArray[indexPath.item]
        guard let urlString = photosArray["url"] as? String else {return cell}
       // guard let url = photoArray as? [Dictionary<String,Any>] else{return cell}
      //  guard let url = URL(string: "https://cdn2.thecatapi.com/images/4k4.gif") else {return cell}
        guard let url = URL(string: urlString) else {return cell}
        catCell.thisImageView.setGifFromURL(url)
       // catCell.thisImageView.setImageWith(url)
        return cell
    }
    
    func loadGifs(){
        RequestManager.getCatGif { (responseArray) in
            self.photoArray = responseArray
            self.tableView.reloadData()
        }
    }
    
    
    
}
