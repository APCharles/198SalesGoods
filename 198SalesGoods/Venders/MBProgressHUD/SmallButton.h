//
//  SmallButton.h
//  pnadaBusinessDriver
//
//  Created by BST on 16/9/13.
//  Copyright © 2016年 beisite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallButton : UIButton

//Apple的iOS人机交互设计指南中指出，按钮点击热区应不小于44x44pt，否则这个按钮就会让用户觉得“很难用”，因为明明点击上去了，却没有任何响应。
//
//但我们有时做自定义Button的时候，设计图上的给出按钮尺寸明显要小于这个数。
//
//这个问题在WWDC 2012 Session 216视频中提到了一种解决方式。它重写了按钮中的pointInside方法，使得按钮热区不够44×44大小的先自动缩放到44×44，再判断触摸点是否在新的热区内。
@end
