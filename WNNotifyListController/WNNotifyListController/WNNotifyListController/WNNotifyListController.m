//
//  WNNotifyListController.m
//  WNNotifyListController
//
//  Created by Way_Lone on 2017/4/5.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import "WNNotifyListController.h"
#define SelectAnimationDuration 0.3
enum{
    BlockType_ContentView = 101,
    BlockType_TitleLabel = 102,
    BlockType_DetailLabel = 103
};
@interface WNNotifyListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) WNNotifyListUtil *notifyListUtil;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) TableSelectBlock select;
@property(nonatomic,assign) NSInteger cellHeight;
//选择条目后涉及到的一些属性
@property(nonatomic,assign) BOOL isSelecting;
@property(nonatomic,assign) CGRect sRect;


@end

@implementation WNNotifyListController
-(instancetype)initWithNotifyListInfo:(WNNotifyListUtil*)notifyListUtil cellHeight:(CGFloat)height tableSelectBlock:(TableSelectBlock)select{
    if (self = [super init]) {
        self.notifyListUtil = notifyListUtil;
        self.select = select;
        self.cellHeight = height;
        self.isSelecting = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = HEXCOLOR(self.notifyListUtil.notifyListInfo.cellBackgroundHColor);
    self.tableView.tableFooterView = [UIView new];
    if (self.notifyListUtil.notifyListInfo.notifyType == NotifyType_DefaultBlockType) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.notifyListUtil.titleListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = @"";
    NSString *detail = @"";
    if (self.notifyListUtil.titleListArray.count>indexPath.row) {
        title = self.notifyListUtil.titleListArray[indexPath.row];
    }
    if (self.notifyListUtil.detailListArray.count>indexPath.row) {
        detail = self.notifyListUtil.detailListArray[indexPath.row];
    }
    WNNotifyListInfo *info = self.notifyListUtil.notifyListInfo;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotifyCell"];
#pragma mark 分类型
    //NotifyType 为 DefaultBlockType
    if(info.notifyType == NotifyType_TraditionalListType){
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NotifyCell"];
            UIView *view = [[UIView alloc]init];
            
            view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.cellHeight);
            cell.backgroundColor = HEXCOLOR(info.cellBackgroundHColor);
            view.backgroundColor = HEXCOLOR(info.contentBackgroudHColor);
            [cell addSubview:view];
            view.tag = BlockType_ContentView;
            CGFloat pre = 20;
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(pre, 4, view.frame.size.width-pre*2, 30)];
            titleLabel.textColor = HEXCOLOR(info.titleHColor);
            titleLabel.font = [UIFont systemFontOfSize:15];
            [view addSubview:titleLabel];
            titleLabel.tag = BlockType_TitleLabel;
            
            UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(pre, titleLabel.frame.origin.y+titleLabel.frame.size.height+4, view.frame.size.width - pre*2, view.frame.size.height - (titleLabel.frame.origin.y+titleLabel.frame.size.height+8)-4)];
            detailLabel.textColor = HEXCOLOR(info.detailHColor);
            detailLabel.font = [UIFont systemFontOfSize:12];
            detailLabel.numberOfLines = 0;
            
            [view addSubview:detailLabel];
            detailLabel.tag = BlockType_DetailLabel;
        }
        UILabel *titleLabel = [cell viewWithTag:BlockType_TitleLabel];
        titleLabel.text = title;
        UILabel *detailLabel = [cell viewWithTag:BlockType_DetailLabel];
        detailLabel.text = detail;
        
    }
    //NotifyType 为 DefaultBlockType
    else if(info.notifyType == NotifyType_DefaultBlockType){
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NotifyCell"];
            UIView *view = [[UIView alloc]init];
            
            view.frame = CGRectMake(20, 10, self.view.frame.size.width - 40, self.cellHeight - 20);
            cell.backgroundColor = HEXCOLOR(info.cellBackgroundHColor);
            view.backgroundColor = HEXCOLOR(info.contentBackgroudHColor);
            [self setRoundRadiusWithView:view];
            [cell addSubview:view];
            view.tag = BlockType_ContentView;
            
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 4, view.frame.size.width-16, 30)];
            titleLabel.textColor = HEXCOLOR(info.titleHColor);
            titleLabel.font = [UIFont systemFontOfSize:15];
            [view addSubview:titleLabel];
            titleLabel.tag = BlockType_TitleLabel;
            
            UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, titleLabel.frame.origin.y+titleLabel.frame.size.height+4, view.frame.size.width - 16, view.frame.size.height - (titleLabel.frame.origin.y+titleLabel.frame.size.height+8))];
            detailLabel.textColor = HEXCOLOR(info.detailHColor);
            detailLabel.font = [UIFont systemFontOfSize:12];
            detailLabel.numberOfLines = 0;
            
            [view addSubview:detailLabel];
            detailLabel.tag = BlockType_DetailLabel;
            
        }
        UILabel *titleLabel = [cell viewWithTag:BlockType_TitleLabel];
        titleLabel.text = title;
        UILabel *detailLabel = [cell viewWithTag:BlockType_DetailLabel];
        detailLabel.text = detail;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.notifyListUtil.notifyListInfo.notifyType == NotifyType_DefaultBlockType) {
        if (self.cellHeight<100) {
            return 100;
        }
        return self.cellHeight;
        
    }
    if (self.cellHeight<44) {
        return 44;
    }
    return self.cellHeight;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isSelecting == NO) {
        self.isSelecting = YES;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIView *view = [cell viewWithTag:BlockType_ContentView];
        CGRect rect = [view convertRect:view.bounds toView:[UIApplication sharedApplication].keyWindow];
        [self selectWithIndex:indexPath.row fromRect:rect];
    }
    if (self.select) {
        self.select(indexPath.row);
    }
}
-(BOOL)isHexColor:(NSInteger)hColor{
    if (hColor <= 0xffffff && hColor >= 0x000000) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark method

//设置圆角
-(void)setRoundRadiusWithView:(UIView*)view{
    //UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:view.bounds.size];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:5];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = view.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
    
}
//点击后弹出详情
-(void)selectWithIndex:(NSInteger)index fromRect:(CGRect)rect{
    NSArray *titleArray = self.notifyListUtil.titleListArray;
    NSArray *detailArray = self.notifyListUtil.detailListArray;
    UIView *sView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    sView.backgroundColor = [UIColor clearColor];
    CGFloat p = 0.3;
    CGFloat c2x = rect.size.width*0.5+rect.origin.x;
    CGFloat c2y = rect.size.height*0.5+rect.origin.y;

    CGRect sRect = CGRectMake(c2x-p*rect.size.width*0.5, c2y-p*rect.size.height*0.5, rect.size.width*p, rect.size.height*p);
    self.sRect = sRect;
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = HEXCOLOR(self.notifyListUtil.notifyListInfo.contentBackgroudHColor);
    [sView addSubview:view];
    view.center = CGPointMake(sRect.origin.x+0.5*sRect.size.width, sRect.origin.y+sRect.size.height*0.5);
    //添加子view
    UILabel *cTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, view.frame.size.width-40, 40)];
    cTitle.font = [UIFont systemFontOfSize:20];
    cTitle.textColor = HEXCOLOR(self.notifyListUtil.notifyListInfo.titleHColor);
    cTitle.text = titleArray[index];
    [view addSubview:cTitle];
    
    UITextView *cDetail = [[UITextView alloc]initWithFrame:CGRectMake(20, cTitle.frame.origin.y+cTitle.frame.size.height+30, view.frame.size.width-40, view.frame.size.height-60-(cTitle.frame.origin.y+cTitle.frame.size.height))];
    cDetail.font = [UIFont systemFontOfSize:14];
    cDetail.textColor = HEXCOLOR(self.notifyListUtil.notifyListInfo.detailHColor);
    cDetail.text = detailArray[index];
    cDetail.editable = NO;
    [view addSubview:cDetail];
    [view setTransform:CGAffineTransformMakeScale(p, p)];
    view.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:sView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [view addGestureRecognizer:tap];
    [UIView animateWithDuration:SelectAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //view.frame = [UIScreen mainScreen].bounds;
        [view setTransform:CGAffineTransformMakeScale(1, 1)];
        view.center = sView.center;
        view.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)tapGesture:(UITapGestureRecognizer*)tapGesture {
    CGRect sRect = self.sRect;
    UIView *view = tapGesture.view;
    [UIView animateWithDuration:SelectAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [view setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
        view.center = CGPointMake(sRect.origin.x+0.5*sRect.size.width, sRect.origin.y+sRect.size.height*0.5);
        view.alpha = 0;
    } completion:^(BOOL finished) {
        
        [tapGesture.view.superview removeFromSuperview];
    }];
    self.isSelecting = NO;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
