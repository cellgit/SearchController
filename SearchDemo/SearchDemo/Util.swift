//
//  Util.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/6/23.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit
import SwiftyJSON

class Util {
    private static let json = JSON(parseJSON: try! String(contentsOfFile: Bundle.main.path(forResource: "keywords", ofType: "json")!))
    private init() {}
    
    private class func getSearchResult(_ keyword: String) -> JSON {
        var returnArray: [JSON] = []
        for item in json.arrayValue {
            if item["detail"]["title"].stringValue.contains(keyword) == true {
                returnArray.append(item)
            }
        }
        let jsonResult = JSON(returnArray)
        return jsonResult
    }
    
    class func search(_ keyword: String, _ call: @escaping ((_ list: JSON) -> Void)) {
        
        let json = getSearchResult(keyword)
        
        DispatchQueue.global().async {
            call(json)
        }
    }
}
