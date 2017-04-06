//
//  WNNotifyListController.h
//  WNNotifyListController
//
//  Created by Way_Lone on 2017/4/5.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNNotifyListUtil.h"
typedef void (^TableSelectBlock) (NSInteger index);
@interface WNNotifyListController : UIViewController
-(instancetype)initWithNotifyListInfo:(WNNotifyListUtil*)notifyListUtil cellHeight:(CGFloat)height tableSelectBlock:(TableSelectBlock)select;
@end
