//
//  VideoScene.swift
//  ThreeSixtyPlayer
//
//  Created by Alfred Hanssen on 10/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import SpriteKit
import AVFoundation

class VideoScene: SKScene
{
    /// The SpriteKit node that displays the video.
    private let skVideoNode: SKVideoNode

    // TODO: is initial value of .zero ok?
    init(player: AVPlayer, initialConfiguration: VideoSceneConfiguration)
    {
        self.skVideoNode = SKVideoNode(avPlayer: player)
        self.skVideoNode.xScale = -1 // Flip the video so it's oriented properly when facing inward
        self.skVideoNode.yScale = -1
        
        super.init(size: .zero)
        
        self.scaleMode = .aspectFit
        self.addChild(self.skVideoNode)
        
        self.updateConfiguration(initialConfiguration)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateConfiguration(_ configuration: VideoSceneConfiguration)
    {
        let resolution = configuration.resolution
        
        if let mapping = configuration.stereoscopicMapping
        {
            let sceneSize = mapping.sceneSize(videoResolution: resolution)
            
            self.skVideoNode.anchorPoint = mapping.videoNodeAnchorPoint
            self.skVideoNode.position = sceneSize.midPoint
            self.skVideoNode.size = resolution
            self.size = sceneSize
        }
        else
        {
            self.skVideoNode.position = resolution.midPoint
            self.skVideoNode.size = resolution
            self.size = resolution
        }
    }
}

