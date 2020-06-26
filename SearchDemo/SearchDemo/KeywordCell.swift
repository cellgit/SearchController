//
//  KeywordCell.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/6/23.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit
import SnapKit


enum StockType {
    case in_stock
    case out_stcok
    
    var subtitle: String {
        switch self {
        case .in_stock: return "In-stock"
        case .out_stcok: return "Out-of-stock"
        }
    }
}

enum TextFont {
    case title
    case subtitle
    case price
    
    var font: UIFont {
        switch self {
        case .title: return UIFont.boldSystemFont(ofSize: 15)
        case .subtitle: return UIFont.systemFont(ofSize: 13)
        case .price: return UIFont.systemFont(ofSize: 13)
        }
    }
}

class KeywordCell: UITableViewCell,CellProtocol {
    
    fileprivate lazy var titleLabel = UILabel()
    fileprivate lazy var subtitleLabel = UILabel()
    fileprivate lazy var priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        layout()
    }
    
    fileprivate func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(priceLabel)
        
        titleLabel.font = TextFont.title.font
        subtitleLabel.font = TextFont.subtitle.font
        priceLabel.font = TextFont.price.font
        subtitleLabel.textColor = .lightGray
        
        priceLabel.backgroundColor = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        priceLabel.textAlignment = .center
    }
    
    
    func layout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(15)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.right.greaterThanOrEqualTo(contentView.snp.right).offset(-100)
        }
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.greaterThanOrEqualTo(self.snp.right).offset(-100)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
    
    func refresh(_ model: Keyword) {
        titleLabel.text = model.detail?.title
        subtitleLabel.text = model.detail?.subtitle
        priceLabel.text = model.detail?.price
        
        switch model.detail?.subtitle {
        case StockType.in_stock.subtitle:
            priceLabel.textColor = .link
        default:
            priceLabel.textColor = .lightGray
        }
        
        if let price = model.detail?.price {
            let size = textSize(text: price, font: TextFont.price.font)
            
            priceLabel.snp.makeConstraints { (make) in
                make.right.equalTo(contentView.snp.right).offset(-15)
                make.centerY.equalTo(contentView)
                make.width.equalTo(size.width + 38)
                make.height.equalTo(size.height + 10)
            }
            
            priceLabel.layer.cornerRadius = (size.height + 10) / 2
            priceLabel.layer.masksToBounds = true
        }
    }
    
    func textSize(text : String , font : UIFont) -> CGSize{
        let maxSize = CGSize(width: UIScreen.main.bounds.width - 15*2, height: CGFloat(MAXFLOAT))
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
