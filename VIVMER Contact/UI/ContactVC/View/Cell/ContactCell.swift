//
//  ContactCell.swift
//  MVC Contact
//
//  Created by UziApel on 08/01/19.
//  Copyright © 2019 uzi. All rights reserved.
//

import UIKit
import AlamofireImage

class ContactCell: UITableViewCell {
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var phonenumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoView.layer.cornerRadius = photoView.frame.width/2
        self.layoutIfNeeded()
    }
    
    func imageProfile(url : String){
        self.photoView.af_setImage(withURL: URL(string: url)!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
