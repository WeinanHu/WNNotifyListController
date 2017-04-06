//
//  WNNotifyListInfo.h
//  WNNotifyListController
//
//  Created by Way_Lone on 2017/4/5.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
typedef NS_ENUM(NSInteger,NotifyType){
    NotifyType_DefaultBlockType,
    NotifyType_TraditionalListType
};
@interface WNNotifyListInfo : NSObject
//color
@property(nonatomic,assign) NSInteger cellBackgroundHColor;
@property(nonatomic,assign) NSInteger contentBackgroudHColor;

@property(nonatomic,assign) NSInteger titleHColor;
@property(nonatomic,assign) NSInteger detailHColor;

//type
@property(nonatomic,assign) NotifyType notifyType;
//if notifyType has a ‘Block’ type,you can set the cornerRadius of the block;
@property(nonatomic,assign) NSInteger cornerRadius;

@end
