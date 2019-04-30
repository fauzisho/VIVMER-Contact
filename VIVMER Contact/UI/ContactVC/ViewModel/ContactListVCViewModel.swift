//
//  ContactListVCPresenter.swift
//  VIPER Contact
//
//  Created UziApel on 20/01/19.
//  Copyright © 2019 uzi. All rights reserved.

import UIKit

class ContactListVCViewModel {

    private let interactor : ContactListVCInteractor
    // MARK: - Properties
    public var rooms = Observable<[Contact]>(value: [])
    public var roomsfilter : [Contact] = []
    public var isError = Observable<String>(value: "")
    public var isLoading = Observable<Bool>(value: false)

    
    init(interactor: ContactListVCInteractor) {
        self.interactor = interactor
    }
    
    func showResponse(lists: [Contact]) {
        self.rooms.value = lists
        self.roomsfilter = lists
    }
    
    func updateFilterRoom(){
        self.roomsfilter = self.rooms.value
    }
    
    func getContact() {
        interactor.getContact()
    }
    
    func getContactGender(gender: String) {
        interactor.getContactGender(gender: gender)
    }
}
