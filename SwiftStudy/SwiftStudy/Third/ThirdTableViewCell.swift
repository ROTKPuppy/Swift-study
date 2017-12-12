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
    lazy var player: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    /// 无UI播放器
    lazy var playerLayer: AVPlayerLayer = {
        let playerLayer = AVPlayerLayer(player: player)
        return playerLayer
    }()
    /// 视频播放视图
    lazy var playerView: UIView = {
        let playerView = UIView()
        playerView.alpha = 0
        playerView.layer.addSublayer(playerLayer)
        return playerView
    }()
    
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
    
    // MARK: - 动画

}
