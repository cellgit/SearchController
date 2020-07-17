//
//  TestVC.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/7/12.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit

class TestVC: UIViewController,CatEatFish,DogRun {
    
    private var cat = Cat()
    lazy private var dog = Dog()
    
    
    @IBOutlet weak var btn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func action(_ sender: UIButton) {
        cat.fire()
        // 相当于继承了 CatEatFish, DogRun, 协议中的函数名不能一样
        eatFish()
        run()
    }
    
    

}
