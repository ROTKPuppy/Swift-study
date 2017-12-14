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
    /// 设备
    lazy var currentDevice: AVCaptureDevice? = {
        let device = AVCaptureDevice.default(.builtInDualCamera,
                                             for: AVMediaType.video,
                                             position: .back)
        return device
    }()
    /// 输入设备
    var input: AVCaptureDeviceInput?
    /// 输出设备
    lazy var output: CapturePhotoOutput = {
        let output = CapturePhotoOutput()
        return output
    }()
    
    // MARK: - 代理
    
    // MARK: - 重写父类方法
    
    // MARK: - 视图生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        /// 获取硬件
        if let device = currentDevice {

            /// 配置硬件
            do {
                try device.lockForConfiguration()
            }catch {}
            
            /// 初始化输入设备
            do {
                input = try AVCaptureDeviceInput(device: device)
            }catch {
                
            }
            
            /// 会话
            let session = AVCaptureSession()
            session.sessionPreset = .hd1920x1080
            if let currentInput = input {
                if session.canAddInput(currentInput) {
                    session.addInput(currentInput)
                }
            }
            
            if session.canAddOutput(output.cameraOutput) {
                session.addOutput(output.cameraOutput)
            }
            
            /// 展示
            let layer = AVCaptureVideoPreviewLayer(session: session)
            layer.frame = view.bounds
            view.layer.addSublayer(layer)
            session.startRunning()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 界面布局
    
    // MARK: - 代理
    
    // MARK: - 响应事件
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        takePhoto()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: - 动画

}

// MARK: - 拍照
extension CameraViewController {
    
    private func takePhoto() {
        output.capturePhoto { (image) in
            if let currentImage = image {
                
                // 保存到相册
                UIImageWriteToSavedPhotosAlbum(currentImage, nil, nil, nil)
            }
        }
    }
}

// MARK: - 点击对焦
extension CameraViewController {
    
}

// MARK: - 捏合缩放对焦
extension CameraViewController {
    
}

// MARK: - 闪光灯
extension CameraViewController {
    
}

// MARK: - 白平衡
extension CameraViewController {
    
}
