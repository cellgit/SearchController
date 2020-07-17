//
//  DepthFirstSearch.swift
//  SearchDemo
//
//  Created by 刘宏立 on 2020/7/8.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import Foundation
import SSZipArchive


public class Stack<T> {
    private var container: [T] = [T]()
    public var isEmpty: Bool { return container.isEmpty }
    public func push(thing: T) { container.append(thing) }
    public func pop() -> T { container.removeLast() }
}
class Node<T>: Comparable, Hashable {
    static func < (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return (lhs.cost + lhs.heuristic) < (rhs.cost + rhs.heuristic)
    }
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs === rhs
    }
    let state: T
    let parent: Node?
    let cost: Float
    let heuristic: Float
    init(state: T, parent: Node?, cost: Float = 0.0, heuristic: Float = 0.0) {
        self.state = state
        self.parent = parent
        self.cost = cost
        self.heuristic = heuristic
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(cost)
        hasher.combine(heuristic)
    }
}
func dfs<StateType: Hashable>(initialState: StateType, goalTestFn: (StateType) -> Bool, successorFn: (StateType) -> [StateType])-> Node<StateType>? {
    let frontier: Stack<Node<StateType>> = Stack<Node<StateType>>()
    frontier.push(thing: Node(state: initialState, parent: nil))
    var explored: Set<StateType> = Set<StateType>()
    explored.insert(initialState)
    while !frontier.isEmpty {
        let currentNode = frontier.pop()
        let currentState = currentNode.state
        if goalTestFn(currentState) {
            return currentNode
        }
        for child in successorFn(currentState) where !explored.contains(child) {
            explored.insert(child)
            frontier.push(thing: Node(state: child, parent: currentNode))
        }
    }
    return nil
}


func copyFile(fpath:String,tpath:String) {
    do{
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: tpath){
            try fileManager.removeItem(atPath: tpath)
        }
        
        try fileManager.copyItem(atPath: fpath, toPath: tpath)
        
    }catch{}
}

func copyFileToDocumentLib() {
    
    var resourcePath = Bundle.main.resourcePath
    resourcePath = resourcePath?.appending("/test_file")
//    let pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)
    
    
    
    
    
//    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
//
//        resourcePath = [resourcePath stringByAppendingString:@"/localData"];
//
//        NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//
//        // 创建一个文件管理器
//
//        NSFileManager *manager = [NSFileManager defaultManager];
//
//        NSString *filePath = [[pathArray firstObject] stringByAppendingPathComponent:@"/localData"];

}



/**
 解压文件到指定的路径
 
 @param filePath 将要解压文件的全路径
 @param destinationPath 解压目标路径
 @param fileName 解压文件名
 @return 是否解压完成
*/


class Unzip: NSObject {
    
    
    func unzip(_ filePath: String, _ destinationPath: String, _ fileName: String) {
        var unzipSucceed: Bool = false
        let unzipPath: String = destinationPath + fileName + "-unzip"
        let unzipCompletePath: String = destinationPath + fileName
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destinationPath) {
            do {
                try fileManager.createDirectory(atPath: destinationPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                fatalError("Error1")
            }
        }
        
        SSZipArchive.unzipFile(atPath: filePath, toDestination: unzipPath) { (entry, zipInfo, entryNumber, total) in
            
        } completionHandler: { (path, succeeded, error) in
            if succeeded == false {
                do {
                    try FileManager.default.removeItem(atPath: unzipPath)
                    unzipSucceed = succeeded
                } catch {
                    fatalError("Error2")
                }
            }
            else {
                
                do {
                    try FileManager.default.moveItem(atPath: unzipPath, toPath: unzipCompletePath)
                } catch {
                    fatalError("Error3")
                }
            }
            
            if error != nil {
                unzipSucceed = false
            }
            else {
                unzipSucceed = true
                
                // 解压成功
                
                
                
                
                
                
            }
        }
    }
    
    func getfileName(_ unzipPath: String) {
        
        var nameList = [String]()
        
        
        let fileManager = FileManager.default
        
        do {
            let dirList = try fileManager.contentsOfDirectory(atPath: unzipPath)
            var path = "/Users/liuhongli/Desktop/FileTest"
            
            let buffer: UnsafeMutablePointer<ObjCBool>? = nil
            
            var isDir: Bool = true
            
            while isDir {
                if fileManager.fileExists(atPath: path, isDirectory: buffer) {
                    let subPaths = fileManager.subpaths(atPath: path)
                    /// 怎么重新开始循环
                    subPaths?.forEach({ (subPath) in
                        path = subPath
                        isDir = FileManager.directoryIsExists(path: path)
                        
                        if isDir == false {
                            nameList.append(fileManager.displayName(atPath: path))
                        }
                    })
                } else {
                    break
                }
            }
        } catch {
            fatalError("Error4")
        }
    }
}


//for path in dirList {
//
//    try fileManager.attributesOfItem(atPath: path)
//    // 判断是否是文件夹
//    let isDir = FileManager.directoryIsExists(path: path)
//
//    //1. 是
//
//}


extension FileManager {
    // 判断是否是文件夹的方法
    static func directoryIsExists (path: String) -> Bool {
        var directoryExists = ObjCBool.init(false)
        let fileExists = FileManager.default.fileExists(atPath: path, isDirectory: &directoryExists)
        return fileExists && directoryExists.boolValue
    }
}



//- (BOOL)unzipWithFilePath:(NSString *)filePath
//          destinationPath:(NSString *)destinationPath
//            unzipFileName:(NSString *)fileName {
//
//
//    __block BOOL unzipSucceed = NO;
//    NSString *unzipPath = [destinationPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", fileName, @“-unzip”];
//    NSString *unzipCompletePath = [destinationPath stringByAppendingPathComponent:fileName];
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if (![fileManager fileExistsAtPath:destinationPath]) {
//        NSError *error = nil;
//        [fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:&error];
//        if (error) {
//            unzipSucceed = NO;
//            return unzipSucceed;
//        }
//    }
//
//    [SSZipArchive unzipFileAtPath:filePath toDestination:unzipPath progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
//    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
//        if (!succeeded) {
//            [[NSFileManager defaultManager] removeItemAtPath:unzipPath
//                                                       error:nil];
//            unzipSucceed = succeeded;
//        } else {
//            NSError * error = nil;
//            [[NSFileManager defaultManager] moveItemAtPath:unzipPath
//                                                    toPath:unzipCompletePath
//                                                     error:&error];
//            if (error) {
//                unzipSucceed = NO;
//            } else {
//                unzipSucceed = YES;
//            }
//
//        }
//    }];
//




func nodeToPath<StateType>(_ node: Node<StateType>) -> [StateType] {
    var path: [StateType] = [node.state]
    var node = node
    while let currentNode = node.parent {
        path.insert(currentNode.state, at: 0)
        node = currentNode
    }
    return path
}


//func getFileName(_ path: String) {
//    let fileManager = FileManager.default
//    fileManager.subpathsOfDirectory(atPath: <#T##String#>)
//    var isDir: ObjCBool = false
//
//    guard let isExist: Bool = fileManager.fileExists(atPath: path, isDirectory: &isDir) == true else { return }
//
//    do {
//        let fileList = try fileManager.contentsOfDirectory(atPath: path)
//
//        print("fileList.first ====== \(fileList), first === \(fileList.first), last === \(fileList.last)")
//
//
//
//
//
////        var index: Int = 0
////
////
////        while index < fileList.count - 1 {
////            fileList[index]
////        }
//
//
//    } catch {
//        fatalError("===== Error")
//    }
    
    
    
    
    
    
//}


func showFiles(path: String) {
    let fileManager: FileManager = FileManager.default
    
    var isDir: Bool = false
    
    let isExist: Bool = fileManager.fileExists(atPath: path)
    
    // 判断是否是目录
    if isExist == true {
        if isDir == true {
            do {
                let dirList = try fileManager.contentsOfDirectory(atPath: path)
//                let issubDir = false
                
                var subPath: String = ""
                
                for str in dirList {
                    subPath = path.appending(str)
                    
                    var isSubDir: Bool = false
                    fileManager.fileExists(atPath: subPath)
                    showFiles(path: subPath)
                }
                
                
            } catch {
                //
                fatalError("error")
            }
//            let dirList = fileManager.contentsOfDirectory(atPath: path)
        }
    }
}


func search() {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let url = NSURL(fileURLWithPath: path)
    if let pathComponent = url.appendingPathComponent("nameOfFileHere") {
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE")
        } else {
            print("FILE NOT AVAILABLE")
        }
    } else {
        print("FILE PATH NOT AVAILABLE")
    }
}








