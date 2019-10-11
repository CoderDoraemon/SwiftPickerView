//
//  SSPlayer.swift
//  SSPlayer_Demo
//
//  Created by Apple on 2018/4/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

import UIKit
import AVFoundation

enum SSPlayerState {
    case failed     // 播放失败
    case buffering  // 缓冲中
    case playing    // 播放中
    case pause      // 暂停播放
    case stopped    // 停止播放
}

enum SSPlayerModel {
    case onlyOnce       // 单曲播放
    case singleCycle    // 单曲循环
    case orderCycle     // 顺序循环
    case shuffleCycle   // 随机循环
    case onceOrderCycle // 一次顺序播放
}

class SSPlayer: NSObject {
    
    /// 播放资源
    fileprivate var playerItem: AVPlayerItem?
    
    /// 播放器
    fileprivate var player: AVPlayer?
    
    /// 播放器显示层
    fileprivate var playerLayer: AVPlayerLayer?
    
    let curentUrl: URL? = nil
    
}

extension SSPlayer {
    
    static let sharedPlayer = SSPlayer()
    
    
    
}

extension SSPlayer {
    
    func play(url: URL, isCache: Bool) {
        let urlAsset = self.player?.currentItem?.asset as! AVURLAsset
        var currentUrl = urlAsset.url
        
        if url == currentUrl || (url.streamingURL() != nil) {
            print("当前播放任务已经存在")
            self.resume()
            return
        }
        
        if ((self.player?.currentItem) != nil) {
            self .removeObserver()
        }
        
        currentUrl = url
        
        if isCache {
            
        }
    }
    
    /// MARK - 播放
    func play() {
        
    }
    
    /// MARK - 暂停
    func pause() {
        
    }
    
    /// MARK - 继续播放
    func resume() {
        
    }
    
    /// MARK - 下一首
    func next() {
        
    }
    
    /// MARK - 上一首
    func upper() {
        
    }
    
    /// MARK - 释放播放器
    func deallocPlayer() {
        
    }
    
    /// 音视频跳转
    ///
    /// - Parameter percentage: 时间百分比
    func seekToTimeWithValue(percentage: CGFloat) {
        
    }
    
    func removeObserver() {
        self.player?.currentItem?.removeObserver(self, forKeyPath: "status")
        self.player?.currentItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        NotificationCenter.default.removeObserver(self)
    }
}

