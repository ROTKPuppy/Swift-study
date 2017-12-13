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
    var currentPlayCell: ThirdTableViewCell?
    
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
        let model = data[indexPath.row] as ThirdModel
        model.indexPath = indexPath
        cell.setModel(model: model)
        cell.delegate = self
        return cell
    }
    
    // MARK: -- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            
            // 寻找中心cell
            playVideo()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 寻找中心cell
        playVideo()
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

extension ThirdViewController {
    
    private func handelCenterCell() -> ThirdTableViewCell {
        
        // 获取屏幕中间cell
        let array = tableView.visibleCells as! [ThirdTableViewCell]
        
        var currentCell: ThirdTableViewCell?
        var value = INT_MAX
        
        for cell in array {
            
            // 转换坐标
            let cellRect = cell.superview!.convert(cell.frame, to: view)
            debugPrint(cell.convert(cell.frame, to: view))
            
            // 判断最靠近屏幕中心的cell
            let difference = abs(Int32(view.frame.size.height * 0.5 - (cellRect.origin.y + cellRect.size.height * 0.5)))
            if value > difference {
                currentCell = cell
                value = difference
            }
        }
        
        return currentCell!
    }
    
    private func playVideo() -> () {
        
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        let url = URL.init(fileURLWithPath: path!)
        // 通知cell播放视频
        let cell = handelCenterCell()
        if let currentCell = currentPlayCell {
            let cellInexPath = tableView.indexPath(for: cell)
            let currentIndexPath = tableView.indexPath(for: currentCell)
            if cellInexPath?.section == currentIndexPath?.section
            && cellInexPath?.row == currentIndexPath?.row {
                return
            }
        }
        
        cell.play(url: url)
        currentPlayCell?.stop(animated: false)
        currentPlayCell = cell
    }
}
