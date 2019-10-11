//
//  URL+Extension.swift
//  SSPlayer_Demo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import Foundation

extension URL {
    
    func streamingURL() -> URL? {
        let compents = NSURLComponents(string: self.absoluteString)
        compents?.scheme = "sreaming"
        
        return compents?.url
    }
    
    func httpURL() -> URL? {
        let compents = NSURLComponents(string: self.absoluteString)
        compents?.scheme = "http"
        return compents?.url
    }
}
