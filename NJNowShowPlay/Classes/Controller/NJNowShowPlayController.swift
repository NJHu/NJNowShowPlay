//
//  NJNowShowPlayController.swift
//  NJNowShowPlay
//
//  Created by NJHu on 2018/7/14.
//

import UIKit
import NJKit
import NJDYPlayer

public class NJNowShowPlayController: NJViewController {
    public var liveUrl: String?
    lazy private var maskControlView = UIView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: self.view.frame.height - UIApplication.shared.statusBarFrame.height))
    private let closeBtn = UIButton(type: .custom)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupMaskControlView()
        view.backgroundColor = UIColor.black
        if let liveUrl = self.liveUrl {
            NJVideoPlayerManager.sharedManager.prepareToPlay(contentURLString: liveUrl, in: maskControlView, shouldAutorotate: false, delegate: self)
        }
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !NJVideoPlayerManager.sharedManager.isPlaying {
            if let liveUrl = self.liveUrl {
                NJVideoPlayerManager.sharedManager.play()
            }
        }
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NJVideoPlayerManager.sharedManager.shutdown()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maskControlView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.frame.width, height: self.view.frame.height - UIApplication.shared.statusBarFrame.height)
        closeBtn.frame = CGRect(x: self.view.frame.width - 34 - 10, y: 20 + UIApplication.shared.statusBarFrame.height, width: 34, height: 34);
        view.bringSubviewToFront(closeBtn)
    }
}
// MARK:- UI
extension NJNowShowPlayController {
    private func setupMaskControlView() -> Void {
        view.addSubview(maskControlView)
        maskControlView.backgroundColor = UIColor.clear
        view.addSubview(closeBtn)
        maskControlView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        closeBtn.setImage(UIImage.nj_image(name: "anchor_close_highlight", bundleClass: NJNowShowPlayController.self), for: .normal)
        closeBtn.setImage(UIImage.nj_image(name: "anchor_close_normal", bundleClass: NJNowShowPlayController.self), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeThisLiveRoom), for: .touchUpInside)
        
        let statusBarBg = UIView()
        statusBarBg.backgroundColor = UIColor.black
        view.addSubview(statusBarBg)
        statusBarBg.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}


// MARK:- StatusBar&Screen
extension NJNowShowPlayController {
    public override var prefersStatusBarHidden: Bool {
        return false
    }
    public  override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    public  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    public override var shouldAutorotate: Bool {
        return false
    }
    // MARK: - about keyboard orientation
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait;
    }
}

// MARK:- action
extension NJNowShowPlayController {
    @objc func closeThisLiveRoom() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- NJVideoPlayerManagerDelegate
extension NJNowShowPlayController: NJVideoPlayerManagerDelegate {
    public func videoPlayerManager(_ videoPlayerManager: NJVideoPlayerManager, titleForContentURLString contentURLString: String) -> String? {
        return liveUrl
    }
}
