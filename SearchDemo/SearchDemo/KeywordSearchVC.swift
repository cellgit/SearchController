//
//  KeywordSearchVC.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/6/23.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit
import SwiftyJSON

class KeywordSearchVC: UIViewController {
    
    fileprivate lazy var tableView = UITableView.init(frame: self.view.frame, style: .grouped)
    fileprivate lazy var datasource = SearchListDataSource()
    
    fileprivate lazy var noDataView = NoDataView.init(frame: self.view.frame)
    
    var keywordlist = [Keyword]()
    
    
    private lazy var searchBar: UISearchBar = {return UISearchBar.init()}()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .magenta
        navigationController?.navigationBar.prefersLargeTitles = true
        initSearchBar()
        initList()
        view.addSubview(noDataView)
    }
    
    func initList() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(KeywordCell.self, forCellReuseIdentifier: KeywordCell.uid)
        tableView.dataSource = datasource
        tableView.delegate = datasource
        datasource.keywordlist = keywordlist
    }
    
    
    func initSearchBar() {
        let searchVC = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchVC
        navigationItem.hidesSearchBarWhenScrolling = false
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.searchBar.placeholder = "Tap here to search"
        searchVC.searchResultsUpdater = self
    }
}


extension KeywordSearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            Util.search(text) { [weak self](json) in
                var array = [Keyword]()
                let dataArray = json.arrayValue
                for item in dataArray {
                    var model = Keyword()
                    model.section_title = item["section_title"].stringValue
                    model.detail = Keyword.KeywordDeatil(item["detail"])
                    array.append(model)
                }
                self?.datasource.keywordlist = array
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    if array.isEmpty, !text.isEmpty {
                        self?.noDataView.isHidden = false
                    }
                    else {
                        self?.noDataView.isHidden = true
                    }
                }
            }
        }
    }
}
