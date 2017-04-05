//
//  UITableView+AutoZoomHeader.h
//  下拉缩放头部视图
//
//  Created by Babr2 on 17/3/27.
//  Copyright © 2017年 Babr2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (AutoZoomHeader)

-(void)zh_setHeaderWithImage:(UIImage *)image frame:(CGRect)frame;

-(void)zh_setHeaderWithURL:(NSURL *)imageURL frame:(CGRect)frame;

@end
