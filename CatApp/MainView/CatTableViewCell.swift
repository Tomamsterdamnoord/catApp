//
//  CatTableViewCell.swift
//  CatApp
//
//  Created by Tom Pruimboom on 29/05/2019.
//  Copyright © 2019 Tom Pruimboom. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    static let IDENTIFIER = "CatTableViewCell"
    static var NIBFILE: UINib
    {
        get{
            return UINib(nibName: self.IDENTIFIER, bundle: nil)
        }
    }

    @IBOutlet weak var seeMoreLabel: UILabel!
    @IBOutlet weak var thisImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
