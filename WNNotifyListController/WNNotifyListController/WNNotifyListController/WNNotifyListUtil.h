//
//  WNNotifyListUtil.h
//  WNNotifyListController
//
//  Created by Way_Lone on 2017/4/5.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WNNotifyListInfo.h"
@interface WNNotifyListUtil : NSObject
@property(nonatomic,strong) WNNotifyListInfo *notifyListInfo;

@property(nonatomic,strong) NSArray *titleListArray;
@property(nonatomic,strong) NSArray *detailListArray;


@end
