//
//  FileTestVC.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/7/10.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit

class FileTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 60)
        btn.backgroundColor = .systemBlue
        view.addSubview(btn)
        btn.setTitle("button", for: .normal)
        btn.addTarget(self, action: #selector(action), for: .touchUpInside)
    }
    
    @objc
    func action() {
        getfileName()
    }
    
    func getfileName() {
        
        var nameList = [String]()
        
        
        let fileManager = FileManager.default
        
        do {
//            let dirList = try fileManager.contentsOfDirectory(atPath: unzipPath)
            var path = "/Users/liuhongli/Desktop/FileTest"
            
            let buffer: UnsafeMutablePointer<ObjCBool>? = nil
            
            var isDir: Bool = true
            
            
//            if fileManager.fileExists(atPath: path, isDirectory: buffer) {
////                let subPaths = fileManager.subpaths(atPath: path)
//
//                do {
//                    let subPaths = try fileManager.contentsOfDirectory(atPath: path)
//                    /// 怎么重新开始循环
//                    subPaths.forEach({ (subPath) in
//                        path = subPath
//                        isDir = FileManager.directoryIsExists(path: path)
//                        if isDir == false {
//                            let name = fileManager.displayName(atPath: path)
//                            nameList.append(name)
//                            print("=====count \(nameList.count) name = \(name)")
//                        }
//                    })
//
//                } catch {
//                    fatalError("Error5")
//                }
//
//
//
//            }
            
            
            
            
            while isDir {
                if fileManager.fileExists(atPath: path, isDirectory: buffer) {
//                    let subPaths = fileManager.subpaths(atPath: path)
                    
                    isDir = fileManager.fileExists(atPath: path)
                    
                    do {
                        let subPaths = try fileManager.contentsOfDirectory(atPath: path)
                        
                        
                        
                        var idx: Int = 0
                        
                        var isSubDir = false
                        print("=====subPaths.count \(subPaths.count)")
                        
                        while idx <= subPaths.count - 1 {
//                            let p = path + "/" + subPaths[idx]
                            
                            path = subPaths[idx]//p
                            
                            print("path == \(path) \(idx)")
                            
                            
                            isSubDir = FileManager.directoryIsExists(path: path)
                            
                                //fileManager.fileExists(atPath: path, isDirectory: buffer)
                            //FileManager.directoryIsExists(path: path)
                            //fileManager.fileExists(atPath: path)
                            
//                            print("isSubDir === \(isSubDir)")
                            
                            
                            if isSubDir == false {
                                let name = fileManager.displayName(atPath: path)
                                nameList.append(name)
                                print("=====count \(nameList.count) name = \(name)")
                            }
                            else {
                                isDir = true
                            }
                            
                            idx = idx + 1
                        }
                        
                        
                        /// 怎么重新开始循环
//                        subPaths.forEach({ (subPath) in
//                            path = subPath
//
//                            isDir = fileManager.fileExists(atPath: path)//fileManager.fileExists(atPath: path, isDirectory: buffer)
//                            //FileManager.directoryIsExists(path: path)
//                            print("isDir === \(isDir)")
//
//                            if isDir == false {
//                                let name = fileManager.displayName(atPath: path)
//                                nameList.append(name)
//                                print("=====count \(nameList.count) name = \(name)")
//                            }
//
//                        })
                        
                    } catch {
                        fatalError("Error5")
                    }
                    

                    /// 怎么重新开始循环
//                    subPaths?.forEach({ (subPath) in
//                        path = subPath
////                        isDir = fileManager.fileExists(atPath: path, isDirectory: buffer)
//                        if isDir == false {
//                            let name = fileManager.displayName(atPath: path)
//                            nameList.append(name)
//                            print("=====count \(nameList.count) name = \(name)")
//                        }
//                    })
                } else {
                    break
                }
            }
        } catch {
            fatalError("Error4")
        }
    }

}
