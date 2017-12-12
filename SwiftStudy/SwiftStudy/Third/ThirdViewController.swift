//
//  ThirdViewController.swift
//  SwiftStudy
//
//  Created by H on 2017/12/12.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit
import AVKit

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ThirdTableViewCellDelegate {
    
    // MARK: - 属性
    
    var playViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    /// 数据源
    let data = [
        
        ThirdModel.init(image: "videoScreenshot01",
                        title: "Introduce 3DS Mario",
                        source: "Youtube - 06:32"),
        ThirdModel.init(image: "videoScreenshot02",
                        title: "Emoji Among Us",
                        source: "Vimeo - 3:34"),
        ThirdModel.init(image: "videoScreenshot03",
                        title: "Seals Documentary",
                        source: "Vine - 00:06"),
        ThirdModel.init(image: "videoScreenshot04",
                        title: "Adventure Time",
                        source: "Youtube - 02:39"),
        ThirdModel.init(image: "videoScreenshot05",
                        title: "Facebook HQ",
                        source: "Facebook - 10:20"),
        ThirdModel.init(image: "videoScreenshot06",
                        title: "Lijiang Lugu Lake",
                        source: "Allen - 20:30"),
        
        ThirdModel.init(image: "videoScreenshot01",
                        title: "Introduce 3DS Mario",
                        source: "Youtube - 06:32"),
        ThirdModel.init(image: "videoScreenshot02",
                        title: "Emoji Among Us",
                        source: "Vimeo - 3:34"),
        ThirdModel.init(image: "videoScreenshot03",
                        title: "Seals Documentary",
                        source: "Vine - 00:06"),
        ThirdModel.init(image: "videoScreenshot04",
                        title: "Adventure Time",
                        source: "Youtube - 02:39"),
        ThirdModel.init(image: "videoScreenshot05",
                        title: "Facebook HQ",
                        source: "Facebook - 10:20"),
        ThirdModel.init(image: "videoScreenshot06",
                        title: "Lijiang Lugu Lake",
                        source: "Allen - 20:30")
        
    ]
    
    /// 内容视图
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 220
        return tableView
    }()
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - 界面布局
    
    @objc private func setupUI() -> () {
        
        // 界面样式
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // 注册控件
        tableView.register(ThirdTableViewCell.self,
                           forCellReuseIdentifier: ThirdTableViewCellReId)
        
        // 添加控件
        view.addSubview(tableView)
        
        // 布局控件
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: - 代理
    
    // MARK: -- ThirdTableViewCellDelegate
    
    func playAction(sender: UIButton) {
        loadResource()
    }
    
    // MARK: -- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ThirdTableViewCellReId,
                                                 for: indexPath) as! ThirdTableViewCell
        let model = data[indexPath.row]
        cell.videoScreenshot.image = UIImage.init(named: model.video.image)
        cell.videoTitleLabel.text = model.video.title
        cell.videoSourceLabel.text = model.video.source
        cell.delegate = self
        return cell
    }
    
    // MARK: -- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - 响应事件
    
    // MARK: - 动画
    
    // MARK: - Other
    
    func loadResource() -> () {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        playerView = AVPlayer(url: URL.init(fileURLWithPath: path!))
        playViewController.player = playerView
        present(playViewController, animated: true) { [unowned self] in
            self.playerView.play()
        }
    }
}
