//
//  Keyword.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/6/23.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Keyword {
    var section_title: String?
    var detail: KeywordDeatil?
    
    struct  KeywordDeatil{
        var title: String?
        var subtitle: String?
        var desc: String?
        var price: String?
        init() {}
        init(_ json: JSON) {
            title = json["title"].stringValue
            subtitle = json["subtitle"].stringValue
            desc = json["desc"].stringValue
            price = json["price"].stringValue
        }
    }
    
    init() {}
    init(_ json: JSON) {
        section_title = json["section_title"].stringValue
        detail = parseDetail(json: json["detail"])
    }
    
    func parseDetail(json: JSON) -> KeywordDeatil {
        let model = KeywordDeatil(json)
        return model
    }
}


