//
//  ViewController.swift
//  myListGitRepository
//
//  Created by Denis Mashkov on 15.08.2020.
//  Copyright © 2020 Denis Mashkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var apiService = ApiService()
    var publickRepositories = [PublickRepositories]()
    var myTableView = UITableView()
    let identifyre = "MyCell"
    var array = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        apiService.getData { (result) in
            do {
                self.publickRepositories = try result.get()
            }
            catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }
    
    //MARK: - Table
    
    func createTable() {
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifyre)
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(myTableView)
    }
    
    // - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publickRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifyre, for: indexPath)
        
        let number = publickRepositories[indexPath.row].fullName
        print(number)
        cell.textLabel?.text = number
        
        return cell
    }
    
    // - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
