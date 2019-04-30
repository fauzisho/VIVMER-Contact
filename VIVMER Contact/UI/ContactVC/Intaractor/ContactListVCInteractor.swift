//
//  ContactListVCInteractor.swift
//  VIPER Contact
//
//  Created UziApel on 20/01/19.
//  Copyright © 2019 uzi. All rights reserved.

import UIKit
import SwiftyJSON

class ContactListVCInteractor {
    weak var viewModel: ContactListVCViewModel?
    func getContact() {
        ApiContact.getContact { (response) in
            switch(response){
            case .succeed(let data):
                var lists : [Contact] = []
                let dataJSON = JSON(data)
                for list in dataJSON["results"].arrayValue {
                    let w = Contact()
                    w.name = list["name"]["title"].stringValue + " " + list["name"]["first"].stringValue + " " + list["name"]["last"].stringValue
                    w.image = list["picture"]["large"].stringValue
                    w.phone = list["phone"].stringValue
                    lists.append(w)
                }
                self.viewModel?.showResponse(lists: lists)
                break
            case .failed(let m):
                break
            default:
                break
            }
        }
    }
    func getContactGender(gender: String) {
        ApiContact.getContactGender(gender: gender) { (response) in
            switch(response){
            case .succeed(let data):
                let dataJSON = JSON(data)
                var lists : [Contact] = []
                
                for list in dataJSON["results"].arrayValue {
                    let w = Contact()
                    w.name = list["name"]["title"].stringValue + " " + list["name"]["first"].stringValue + " " + list["name"]["last"].stringValue
                    w.image = list["picture"]["large"].stringValue
                    w.phone = list["phone"].stringValue
                    lists.append(w)
                }
                self.viewModel?.showResponse(lists: lists)
                break
            case .failed(let m):
                break
            default:
                break
            }
        }
    }
}
