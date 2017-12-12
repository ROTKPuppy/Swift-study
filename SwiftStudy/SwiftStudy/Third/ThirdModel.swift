//
//  ThirdModel.swift
//  SwiftStudy
//
//  Created by H on 2017/12/12.
//  Copyright © 2017年 H. All rights reserved.
//

import UIKit

enum VideoType {
    case VideoDefault
    case VideoLoading
    case VideoPlaying
    case VideoStop
}

struct Video {
    let image: String
    let title: String
    let source: String
}

class ThirdModel: NSObject {

    /// 当前视频播放类型
    var videoType = VideoType.VideoDefault
    var video: Video
    
    required init(image: String, title: String, source: String) {
        video = Video(image: image, title: title, source: source)
    }
}
