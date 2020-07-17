//
//  ProtocolOne.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/7/12.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import Foundation


class Dog: NSObject {
    func fire() {
        print("Dog is Fire")
    }
}

class Cat: NSObject {
    func fire() {
        print("Cat is Fire")
    }
}



protocol DogRun {}
extension DogRun {
    func run() {
        print("Dog Run Fast")
    }
}

protocol CatEatFish {}
extension CatEatFish {
    func eatFish() {
        print("Cat Eat Fish")
    }
}


