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
    private var maskControlView = UIView()
    private let closeBtn = UIButton(type: .custom)
    private var moviePlayer: NJPlayerController?
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupPlayer()
        setupMaskControlView()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let liveUrl = self.liveUrl {
            var videoUrl = "http://hls1a.douyucdn.cn/live/952595rcJxorfZgs_550/playlist.m3u8?wsSecret=c3abb51298f113ed4640f8b045ba0677&wsTime=1531583033&token=-0-952595-18b09c983aa4b2219e9db330c85d809c&did=132a5f160ab79028a1d4edf600051531"
            moviePlayer?.prepareToPlay(contentURLString: videoUrl)
        }
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeBtn.frame = CGRect(x: self.view.frame.width - 34 - 10, y: 20, width: 34, height: 34);
    }
}
// MARK:- UI
extension NJNowShowPlayController {
    private func setupPlayer() {
        view.backgroundColor = UIColor.black
        moviePlayer = NJPlayerController(containerView: self.view, delegate: self)
    }
    private func setupMaskControlView() -> Void {
        view.addSubview(maskControlView)
        maskControlView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        maskControlView.frame = view.bounds
        maskControlView.backgroundColor = UIColor.clear
        maskControlView.addSubview(closeBtn)
        closeBtn.setImage(UIImage.nj_image(name: "anchor_close_highlight", bundleClass: NJNowShowPlayController.self), for: .normal)
        closeBtn.setImage(UIImage.nj_image(name: "anchor_close_normal", bundleClass: NJNowShowPlayController.self), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeThisLiveRoom), for: .touchUpInside)
    }
}

// MARK:- NJPlayerControllerDelegate
extension NJNowShowPlayController: NJPlayerControllerDelegate {
    public func playerController(_ playerController: NJPlayerController, playReady contentURLString: String) -> Bool {
        return true
    }
    public func playerController(_ playerController: NJPlayerController, playing contentURLString: String) {
        
    }
    public func playerController(_ playerController: NJPlayerController, loading contentURLString: String) {
        
    }
    public func playerController(_ playerController: NJPlayerController, unKnowFinished contentURLString: String) {
        
    }
    public func playerController(_ playerController: NJPlayerController, finished contentURLString: String) {
        
    }
}

extension NJNowShowPlayController {
    public override var prefersStatusBarHidden: Bool {
        return false
    }
    public  override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    public  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    public override var shouldAutorotate: Bool {
        return true
    }
    // MARK: - about keyboard orientation
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.allButUpsideDown;
    }
    //返回最优先显示的屏幕方向
    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
}

// MARK:- action
extension NJNowShowPlayController {
    @objc func closeThisLiveRoom() {
        dismiss(animated: true, completion: nil)
    }
}
