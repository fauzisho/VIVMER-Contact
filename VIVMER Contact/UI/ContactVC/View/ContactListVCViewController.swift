//
//  ContactListVCViewController.swift
//  VIPER Contact
//
//  Created UziApel on 20/01/19.
//  Copyright © 2019 uzi. All rights reserved.

import UIKit

class ContactListVCViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    open var searchViewController: UISearchController!
	var command: ContactListVCViewModel?

	override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
    }
    
    func initBinding(){
        command?.rooms.addObserver(open: true) { (contactList) in
            self.tableView.reloadData()
        }
        command?.isLoading.addObserver { (isLoading) in
            print("check loading \(isLoading)")
        }
        command?.isError.addObserver { (isError) in
            print("check error \(isError)")
        }
        command?.getContact()
    }
    
    func initView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerCell(nib: ContactCell.nib, forCellWithReuseIdentifier: ContactCell.identifier)
        searchViewController = UISearchController(searchResultsController: nil)
        searchViewController.searchResultsUpdater = self
        searchViewController.searchBar.delegate = self
        searchViewController.hidesNavigationBarDuringPresentation = true
        searchViewController.dimsBackgroundDuringPresentation = false
        searchViewController.searchBar.sizeToFit()
        self.navigationItem.title = "Contact List"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        let btnFilterConversation: UIButton       = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let imageFilterConversation: UIImage      = UIImage(named: "ic_keyboard_arrow_right", in: nil, compatibleWith: nil)!
        btnFilterConversation.tintColor           = UIColor.blue
        btnFilterConversation.setImage(imageFilterConversation, for: .normal)
        btnFilterConversation.addTarget(self, action: #selector(self.buttonFilterGender(_:)), for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: btnFilterConversation), animated: true)
        self.tableView.tableHeaderView = searchViewController.searchBar
    }
    
    @objc func buttonFilterGender(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let male = UIAlertAction(title: "Male", style: .default) { (action) in
            self.command?.getContactGender(gender: "male")
        }
        let female = UIAlertAction(title: "Female", style: .default) { (action) in
            self.command?.getContactGender(gender: "female")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        })
        alert.addAction(male)
        alert.addAction(female)
        alert.addAction(cancel)
        UIApplication.currentViewController()?.present(alert, animated: true, completion: nil)
    }
    
    public func registerCell(nib: UINib?, forCellWithReuseIdentifier reuseIdentifier: String) {
        self.tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension ContactListVCViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = ContactDetailVC()
        if searchViewController.isActive {
            detail.detailContact = self.command?.roomsfilter[indexPath.row]
        }else {
            detail.detailContact = self.command?.rooms.value[indexPath.row]
        }
        UIApplication.currentViewController()?.navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchViewController.isActive {
            return self.command?.roomsfilter.count ?? 0
        }else {
            return self.command?.rooms.value.count ?? 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellPrimary = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
        if searchViewController.isActive {
            let data = self.command?.roomsfilter[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
            cell.fullname.text = data?.name
            cell.phonenumber.text = data?.phone
            cell.imageProfile(url: data?.image ?? "")
            cellPrimary = cell
        } else {
            let data = self.command?.rooms.value[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
            cell.fullname.text = data?.name
            cell.phonenumber.text = data?.phone
            cell.imageProfile(url: (data?.image ?? ""))
            cellPrimary = cell
        }
        return cellPrimary
    }
}

extension ContactListVCViewController : UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = self.searchViewController.searchBar.text {
            self.filterContentForSearchText(searchText: searchText)
        }
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.deactivateSaerchBar()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func filterContentForSearchText(searchText: String) {
        print("search text \(searchText)")
        if searchText.isEmpty {
            self.command?.updateFilterRoom()
        } else {
            self.command?.roomsfilter = ((self.command?.rooms.value.filter({ (room) -> Bool in
                return room.name.lowercased().contains(searchText.lowercased())
            }))!)
            if (self.searchViewController?.isBeingDismissed)! {
                removeBackgroundNotFound()
            } else if !searchText.isEmpty && self.command?.roomsfilter.count == 0 {
                showNotFoundSearch(withKeyword: searchText)
            } else {
                removeBackgroundNotFound()
            }
        }
        self.tableView.reloadData()
    }
    
    func activateSaerchbar() {
        self.searchViewController.searchBar.tintColor = UIColor.white
        self.searchViewController.searchBar.showsCancelButton = true
        self.command?.updateFilterRoom()
    }
    
    func deactivateSaerchBar() {
        self.searchViewController.searchBar.barTintColor = UIColor.lightGray
        self.searchViewController.searchBar.showsCancelButton = false
        self.searchViewController.searchBar.tintColor = UIColor.white
        self.removeBackgroundNotFound()
    }
    
    func removeBackgroundNotFound() {
        self.tableView.backgroundView = removeBackground()
        self.tableView.separatorStyle = .none
    }
    
    func showNotFoundSearch(withKeyword: String){
        self.tableView.backgroundView = backgroundSearchNotFound(keyword: withKeyword)
        self.tableView.separatorStyle = .none
    }
    
    func removeBackground() -> UIView {
        let height: CGFloat = UIScreen.main.bounds.height
        let width: CGFloat = UIScreen.main.bounds.width
        let x: CGFloat = 0
        let y: CGFloat = 0
        let view = UIView(frame:CGRect(x: x, y: y, width: width, height: height))
        view.backgroundColor = UIColor.white
        return view
    }
    
    func backgroundSearchNotFound(keyword:String) -> UIView{
        let height: CGFloat = UIScreen.main.bounds.height
        let width: CGFloat = UIScreen.main.bounds.width
        let x: CGFloat = 15
        let y: CGFloat = (height/2)
        let view = UIView(frame:CGRect(x: x, y: y, width: width, height: height))
        // add description
        let description               = UITextView(frame: CGRect(x: x, y: 80, width: width, height: 150))
        description.textAlignment     = NSTextAlignment.center
        description.textColor         = UIColor.black
        description.font              = UIFont.systemFont(ofSize: 17)
        description.text              = "No results found for '\(keyword)'"
        description.isEditable        = false
        view.addSubview(description)
        return view
    }
}


