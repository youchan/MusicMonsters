//
//  MmonViewController.h
//  MusicMonsters
//
//  Created by 大崎 瑶 on 2014/02/22.
//  Copyright (c) 2014年 大崎 瑶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MmonViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(nonatomic, strong) MPMusicPlayerController *player;
- (IBAction)onGetPushed:(id)sender;
@property (weak, nonatomic) NSMutableArray *items;

@end
