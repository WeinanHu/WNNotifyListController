
# WNNotifyListController
it's a convinient controller to show notify.
## 

```Objective-C
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    WNNotifyListUtil *util = [WNNotifyListUtil new];
    WNNotifyListInfo *info = [WNNotifyListInfo new];
    info.cellBackgroundHColor = 0xeeeeee;
    info.contentBackgroudHColor = 0xffffff;
    info.titleHColor = 0x111111;
    info.detailHColor = 0xfabd5d;
    info.notifyType = NotifyType_DefaultBlockType;
    util.notifyListInfo = info;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"InsureNotify.plist" ofType:@""];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    util.titleListArray = dict[@"titleArray"];
    util.detailListArray= dict[@"detailArray"];
    
    self.window = [[UIWindow alloc]init];
    
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[WNNotifyListController alloc]initWithNotifyListInfo:util cellHeight:100 tableSelectBlock:^(NSInteger index) {
        
    }]];
    [self.window makeKeyAndVisible];

    // Override point for customization after application launch.
    return YES;
}
```
### it's a default block type
![image](https://raw.githubusercontent.com/WeinanHu/WNNotifyListController/master/type_b.gif)
### it's a traditional type
![image](https://raw.githubusercontent.com/WeinanHu/WNNotifyListController/master/type_t.gif)
