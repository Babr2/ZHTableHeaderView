//
//  ViewController.m
//  下拉缩放头部视图
//
//  Created by Babr2 on 17/3/27.
//  Copyright © 2017年 Babr2. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+AutoZoomHeader.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView          *tbView;
@property(nonatomic,strong)NSMutableArray       *dataArray;
@property(nonatomic,strong)UIImageView          *imv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self creataTableView];
}

-(void)setup{
    
    _dataArray=[NSMutableArray array];
    for (int i=0; i<100; i++) {
        
        NSString *str=[NSString stringWithFormat:@"第%d行",i];
        
        [_dataArray addObject:str];
    }
    [_tbView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
    
}
-(void)creataTableView{
    
    _tbView=[[UITableView alloc] initWithFrame:CGRectMake(0, 20,self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_tbView];
    _tbView.delegate=self;
    _tbView.dataSource=self;
//    [_tbView zh_setHeaderWithImage:[UIImage imageNamed:@"123.jpeg"] frame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    [_tbView zh_setHeaderWithURL:[NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/2184130-7b9b3226fb67d146.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1080/q/50"] frame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cid=@"cell_id";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    }
    cell.textLabel.text=_dataArray[indexPath.row];
    return cell;
}

@end
