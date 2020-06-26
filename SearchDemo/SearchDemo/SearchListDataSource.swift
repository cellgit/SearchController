//
//  SearchListDataSource.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/6/23.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit

protocol CellProtocol: class {
    static var uid: String {get}
}
extension CellProtocol {
    static var uid: String {
        return String(describing: type(of: self)).components(separatedBy: ".").first!
    }
}

class SearchListDataSource: NSObject,UITableViewDataSource,UITableViewDelegate {
    var keywordlist: [Keyword] = []
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KeywordCell.uid, for: indexPath) as! KeywordCell
        cell.refresh(keywordlist[indexPath.row])
        return cell
    }
}
