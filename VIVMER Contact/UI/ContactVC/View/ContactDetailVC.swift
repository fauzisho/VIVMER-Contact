//
//  ContactDetailVC.swift
//  MVC Contact
//
//  Created by UziApel on 13/01/19.
//  Copyright © 2019 uzi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ContactDetailVC: UIViewController {
    @IBOutlet var imageAvatar: UIImageView!
    @IBOutlet var textFullName: UITextField!
    var detailContact:Contact? = nil
    @IBOutlet var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
    }
    
    private func setUpImageView() {
        if detailContact != nil {
            self.imageAvatar.af_setImage(withURL: URL(string: (detailContact?.image)!)!)
            textFullName.text = detailContact?.name
            phoneNumber.text = detailContact?.phone
        }
    }
}
