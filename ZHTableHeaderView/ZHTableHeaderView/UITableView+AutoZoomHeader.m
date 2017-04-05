//
//  UITableView+AutoZoomHeader.m
//  下拉缩放头部视图
//
//  Created by Babr2 on 17/3/27.
//  Copyright © 2017年 Babr2. All rights reserved.
//

#import "UITableView+AutoZoomHeader.h"
#import <objc/runtime.h>
#import "UIImageView+WebCache.h"

static char *kZhTableHeaderFrameKey ="kZhTableHeaderFrameKey";
static char *kZhAutoZoomImageViewKey="kZhAutoZoomImageViewKey";

@implementation UITableView (AutoZoomHeader)

-(void)zh_setHeaderWithImage:(UIImage *)image frame:(CGRect)frame{
    
    
    UIImageView *imv=[[UIImageView alloc] initWithFrame:frame];
    imv.image=image;
    imv.backgroundColor=[UIColor clearColor];
    imv.contentMode=UIViewContentModeScaleAspectFill;
    
    
    objc_setAssociatedObject(self, kZhTableHeaderFrameKey, [NSValue valueWithCGRect:frame] , OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, kZhAutoZoomImageViewKey, imv, OBJC_ASSOCIATION_RETAIN);
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.tableHeaderView=[[UIView alloc] initWithFrame:frame];
    [self insertSubview:imv atIndex:0];//放在最里层
}

-(void)zh_setHeaderWithURL:(NSURL *)imageURL frame:(CGRect)frame{
    
    UIImageView *imv=[[UIImageView alloc] initWithFrame:frame];
    [imv sd_setImageWithURL:imageURL];
    imv.backgroundColor=[UIColor clearColor];
    imv.contentMode=UIViewContentModeScaleAspectFill;
    
    objc_setAssociatedObject(self, kZhTableHeaderFrameKey, [NSValue valueWithCGRect:frame] , OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, kZhAutoZoomImageViewKey, imv, OBJC_ASSOCIATION_RETAIN);
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.tableHeaderView=[[UIView alloc] initWithFrame:frame];
    [self insertSubview:imv atIndex:0];//放在最里层
//    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
//    [self zh_setHeaderWithImage:image frame:frame];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object!=self) {
        
        return;
    }
    if (![keyPath isEqualToString:@"contentOffset"]) {
        
        return;
    }
    CGPoint offset=[[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
    if (offset.y>0) {
        
        return;
    }
    CGRect frm=[objc_getAssociatedObject(self, kZhTableHeaderFrameKey) CGRectValue];
    UIImageView *imv=objc_getAssociatedObject(self, kZhAutoZoomImageViewKey);
    
    CGFloat width=frm.size.width;
    CGFloat height=frm.size.height;
    CGFloat scale=width/height;
    
    CGFloat x=frm.origin.x;
    CGFloat y=frm.origin.y;
    
    CGFloat new_height=height-offset.y;
    CGFloat new_width=new_height*scale;
    CGFloat new_x=x-(new_width-width)/2;
    CGFloat new_y=y+offset.y;
    imv.frame=CGRectMake(new_x, new_y, new_width, new_height);
}
-(void)dealloc{
    
    [self removeObserver:self forKeyPath:@"contenOffset"];
}
@end
