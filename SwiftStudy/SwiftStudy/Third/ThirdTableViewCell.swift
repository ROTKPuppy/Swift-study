//
//  ThirdTableViewCell.swift
//  SwiftStudy
//
//  Created by H on 2017/12/12.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit
import AVFoundation

/// 重用标志
let ThirdTableViewCellReId = "ThirdTableViewCellReId"

protocol ThirdTableViewCellDelegate {
    func playAction(sender: UIButton)
}

class ThirdTableViewCell: UITableViewCell {

    // MARK: - 属性
    
    /// 数据模型
    var model: ThirdModel?
    
    /// 代理
    var delegate: ThirdTableViewCellDelegate?
    
    /// 视频预览
    lazy var videoScreenshot: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    /// 视频标题
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    /// 播放按钮
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "playBtn"),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(playButtonAction(sender:)),
                         for: .touchUpInside)
        return button
    }()
    /// 视频来源
    lazy var videoSourceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightText
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    /// 播放器
    var player: AVPlayer?
    /// 无UI播放器
    lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer()
        layer.videoGravity = .resizeAspectFill
        return layer
    }()
    /// 视频监听
    var playerItem: AVPlayerItem?
    /// 视频播放视图
    lazy var playerView: UIView = {
        let playerView = UIView()
        playerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        playerView.alpha = 0
        playerView.layer.addSublayer(playerLayer)
        return playerView
    }()
    
    // MARK: - 赋值方法
    func setModel(model: ThirdModel) -> () {
        self.model = model
        
        videoScreenshot.image = UIImage.init(named: model.video.image)
        videoTitleLabel.text = model.video.title
        videoSourceLabel.text = String.init(format: "%@-%d-%d", model.video.source, (model.indexPath?.section)!, (model.indexPath?.row)!)
        
        switch model.videoType {
        case .VideoDefault:
            debugPrint("默认")
            stop(animated: false)
        case .VideoStop:
            debugPrint("停止")
            stop(animated: false)
        case .VideoLoading:
            debugPrint("加载")
            stop(animated: false)
        case .VideoPlaying:
            debugPrint("播放")
            stop(animated: false)
        }
    }
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        contentView.addSubview(videoScreenshot)
        contentView.addSubview(playButton)
        contentView.addSubview(videoTitleLabel)
        contentView.addSubview(videoSourceLabel)
        contentView.addSubview(playerView)
        
        videoScreenshot.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 200, height: 100))
            make.centerX.centerY.equalTo(contentView)
        }
        
        videoTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(playButton.snp.bottom).offset(13)
            make.centerX.equalTo(contentView)
        }
        
        videoSourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(videoTitleLabel.snp.bottom).offset(4)
            make.centerX.equalTo(contentView)
        }
        
        playerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - 界面布局
    
    // MARK: - 代理
    
    // MARK: - 响应事件
    
    @objc private func playButtonAction(sender: UIButton) -> () {
        delegate?.playAction(sender: sender)
    }
    
    func play(url: URL) -> () {
        
        // 配置播放URL
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        playerLayer.player = player!
        playerLayer.frame = contentView.bounds
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        
        // 展示播放界面动画
        showPlayerView()
        
        // 修改枚举值
        model?.videoType = VideoType.VideoLoading
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        model?.videoType = VideoType.VideoPlaying
        player?.play()
    }
    
    func stop(animated: Bool) -> () {
        
        // 关闭视频
        player?.pause()
        
        // 关闭动画
        if animated {
            hiddenPlayerView()
        }else{
            self.playerView.alpha = 0
        }
        
        // 修改枚举值
        model?.videoType = VideoType.VideoStop
        
        // 移除监听
        playerItem?.removeObserver(self, forKeyPath: "status", context: nil)
        playerItem = nil
        player = nil
    }
    
    // MARK: - 动画
    private func showPlayerView() -> () {
        UIView.animate(withDuration: 1) { [unowned self] in
            self.playerView.alpha = 1
        }
    }

    private func hiddenPlayerView() -> () {
        UIView.animate(withDuration: 1) { [unowned self] in
            self.playerView.alpha = 0
        }
    }
}
