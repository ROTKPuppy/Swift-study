//
//  CapturePhotoOutput.swift
//  SwiftStudy
//
//  Created by H on 2017/12/14.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit
import AVFoundation

typealias imageCallBack = (UIImage?)->()

class CapturePhotoOutput: NSObject, AVCapturePhotoCaptureDelegate {
    
    var callBack: imageCallBack?
    let cameraOutput = AVCapturePhotoOutput()
    
    func capturePhoto(callBack: @escaping imageCallBack) {
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160]
        settings.previewPhotoFormat = previewFormat
        self.cameraOutput.capturePhoto(with: settings, delegate: self)
        self.callBack = callBack
    }
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                 resolvedSettings: AVCaptureResolvedPhotoSettings,
                 bracketSettings: AVCaptureBracketedStillImageSettings?,
                 error: Error?) {
        
        
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer,
            let previewBuffer = previewPhotoSampleBuffer,
            let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            callBack?(UIImage(data: dataImage))
            print(UIImage(data: dataImage)?.size)
        }
        
    }
}
