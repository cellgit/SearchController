//
//  NoDataView.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/6/23.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let btn = UIButton.init(type: .custom)
        self.addSubview(btn)
        
        btn.setTitleColor(.lightGray, for: .normal)
        btn.setTitle("No Result", for: .normal)
        let w: CGFloat = 200
        let h: CGFloat = 100
        let x = (self.bounds.width - w) / 2
        let y = (self.bounds.height - h) / 2
        btn.frame = CGRect(x: x, y: y, width: w, height: h)
        
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
