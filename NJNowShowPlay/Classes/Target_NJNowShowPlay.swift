//
//  DYTarget_Trends.swift
//  DYTrends
//
//  Created by HuXuPeng on 2018/6/7.
//

import UIKit
import NJKit

@objc class Target_NJNowShowPlay: NSObject {
    
    @objc func Action_NJNowShowPlayController(params: [String: AnyObject]) -> UIViewController? {
        
        let NowShowPlay = NJNowShowPlayController()
        NowShowPlay.liveUrl = params["liveUrl"] as? String
        return NowShowPlay
    }
}
