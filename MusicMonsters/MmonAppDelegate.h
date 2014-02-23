//
//  MmonAppDelegate.h
//  MusicMonsters
//
//  Created by 大崎 瑶 on 2014/02/22.
//  Copyright (c) 2014年 大崎 瑶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MmonViewController.h"

@interface MmonAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) NSMutableArray *items;
@property (retain, nonatomic) NSString *current;

@end
