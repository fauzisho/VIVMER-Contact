//
//  ContactListVCRouter.swift
//  VIPER Contact
//
//  Created UziApel on 20/01/19.
//  Copyright © 2019 uzi. All rights reserved.

import UIKit

class ContactListVCRouter{

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ContactListVCViewController(nibName: nil, bundle: nil)
        let interactor = ContactListVCInteractor()
        let router = ContactListVCRouter()
        let viewModel = ContactListVCViewModel(interactor: interactor)

        view.command = viewModel
        interactor.viewModel = viewModel
        router.viewController = view

        return view
    }
}
