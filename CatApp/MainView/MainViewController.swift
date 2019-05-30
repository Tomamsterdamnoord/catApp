//
//  ViewController.swift
//  CatApp
//
//  Created by Tom Pruimboom on 29/05/2019.
//  Copyright © 2019 Tom Pruimboom. All rights reserved.
//

// NOTE: API keys are in the code as the code needs to be reviewed and working. Normally I won't push API in a public repository. 

import UIKit
import AFNetworking

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var photoArray =  [Dictionary<String, Any>] ()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    func setup () {
        loadData()
        searchBar.delegate = self
        searchBar.placeholder = NSLocalizedString("Search", comment: "")
        
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
        guard let photoString = photosArray["src"] as? Dictionary<String, Any> else {return cell}
        guard let photo = photoString["small"] as? String else {return cell}
        print("\(photoString)")
        guard let cellPhoto = URL(string: photo) else {return cell}
        catCell.thisImageView.setImageWith(cellPhoto)
        catCell.seeMoreLabel.text = NSLocalizedString("View Image", comment: "")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail",
            let dvc = segue.destination as? DetailViewController {
            dvc.photoArray = photoArray
            dvc.selectedIndex = selectedIndex
        }
    }
    
    
    func loadData(){
        RequestManager.imageGet { (responseDict) in
            guard let photoArray = responseDict["photos"] as? [Dictionary<String, Any>] else {return}
            print("success")
            self.photoArray = photoArray
            self.tableView.reloadData()
        }
    }
    
    // only searches in english
    func searchImages(searchString: String){
        RequestManager.searchImage(searchString: searchString) { (responseDict) in
            guard let photoArray = responseDict["photos"] as? [Dictionary<String, Any>] else {return}
            print("success")
            self.photoArray = photoArray
            self.tableView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != nil else {
            print("No text")
            return
        }
        searchBar.resignFirstResponder()
        guard let string = searchBar.text else {return}
        searchImages(searchString: string)
    }
    

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        loadData()
        tableView.reloadData()
    }
}


