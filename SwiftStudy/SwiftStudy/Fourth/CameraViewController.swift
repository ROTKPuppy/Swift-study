//
//  CameraViewController.swift
//  SwiftStudy
//
//  Created by H on 2017/12/14.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    // MARK: - 属性
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        /// 获取硬件
        let device = AVCaptureDevice.default(.builtInDualCamera,
                                             for: AVMediaType.video,
                                             position: .back)
        
        /// 初始化输入设备
        var input: AVCaptureDeviceInput?
        if let currentDevice = device {
            do {
                input = try AVCaptureDeviceInput(device: currentDevice)
            }catch {
                
            }
        }
        
        /// 图像输出
        let output = AVCapturePhotoOutput()
        
        /// 会话
        let session = AVCaptureSession()
        session.sessionPreset = .hd1920x1080
        if let currentInput = input {
            if session.canAddInput(currentInput) {
                session.addInput(currentInput)
            }
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        
        /// 展示
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        session.startRunning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 界面布局
    
    // MARK: - 代理
    
    // MARK: - 响应事件
    
    // MARK: - 动画

}
