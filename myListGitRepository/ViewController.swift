//
//  ViewController.swift
//  myListGitRepository
//
//  Created by Denis Mashkov on 15.08.2020.
//  Copyright © 2020 Denis Mashkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myTableView = UITableView()
    let identifyre = "MyCell"
    var array = ["1", "2", "3"]
    var publickRepositories = [PublickRepositories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        createTable()
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
        //cell.separatorInset
        
        let number = publickRepositories[indexPath.row].fullName
//        for res in publickRepositories {
//            cell.textLabel?.text = res.fullName
//            print(res.fullName)
//        }
        print(number)
        cell.textLabel?.text = number
        
        return cell
    }
    
    // - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    //MARK: - GET DATA FROM API
    
    func getData() {
        let url : String = "https://api.github.com/repositories?since=0"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            var result = [PublickRepositories]()
            do {
                result = try JSONDecoder().decode([PublickRepositories].self, from: data)
            }
            catch{
                print("failed to convert \(error.localizedDescription)")
            }

            self.publickRepositories = result
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
        })
        task.resume()
    }
}

//MARK: - JSON Schema

struct PublickRepositories: Codable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let myresultPrivate: Bool
    let owner: Owner
    let htmlUrl: String
    let repDescription: String?
    let fork: Bool
    let url: String
    let forksurl: String
    let keysURL: String
    let collaboratorsUrl: String
    let teamsUrl: String
    let hooksUrl: String
    let issueEventsUrl: String
    let eventsUrl: String
    let assigneesUrl: String
    let branchesUrl: String
    let tagsUrl: String
    let blobsUrl: String
    let gitTagsUrl: String
    let gitRefsUrl: String
    let treesUrl: String
    let statusesUrl: String
    let languagesUrl: String
    let stargazersUrl: String
    let contributorsUrl: String
    let subscribersUrl: String
    let subscriptionUrl: String
    let commitsUrl: String
    let gitCommitsUrl: String
    let commentsUrl: String
    let issueCommentUrl: String
    let contentsUrl: String
    let compareUrl: String
    let mergesUrl: String
    let archiveUrl: String
    let downloadsUrl: String
    let issuesUrl: String
    let pullsUrl: String
    let milestonesUrl: String
    let notificationsUrl: String
    let labelsUrl: String
    let releasesUrl: String
    let deploymentsUrl: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case myresultPrivate = "private"
        case owner
        case htmlUrl = "html_url"
        case repDescription = "description"
        case fork
        case url
        case forksurl = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsUrl = "collaborators_url"
        case teamsUrl = "teams_url"
        case hooksUrl = "hooks_url"
        case issueEventsUrl = "issue_events_url"
        case eventsUrl = "events_url"
        case assigneesUrl = "assignees_url"
        case branchesUrl = "branches_url"
        case tagsUrl = "tags_url"
        case blobsUrl = "blobs_url"
        case gitTagsUrl = "git_tags_url"
        case gitRefsUrl = "git_refs_url"
        case treesUrl = "trees_url"
        case statusesUrl = "statuses_url"
        case languagesUrl = "languages_url"
        case stargazersUrl = "stargazers_url"
        case contributorsUrl = "contributors_url"
        case subscribersUrl = "subscribers_url"
        case subscriptionUrl = "subscription_url"
        case commitsUrl = "commits_url"
        case gitCommitsUrl = "git_commits_url"
        case commentsUrl = "comments_url"
        case issueCommentUrl = "issue_comment_url"
        case contentsUrl = "contents_url"
        case compareUrl = "compare_url"
        case mergesUrl = "merges_url"
        case archiveUrl = "archive_url"
        case downloadsUrl = "downloads_url"
        case issuesUrl = "issues_url"
        case pullsUrl = "pulls_url"
        case milestonesUrl = "milestones_url"
        case notificationsUrl = "notifications_url"
        case labelsUrl = "labels_url"
        case releasesUrl = "releases_url"
        case deploymentsUrl = "deployments_url"
    }
}

struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool
    
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}
