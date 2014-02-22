//
//  MmonViewController.m
//  MusicMonsters
//
//  Created by 大崎 瑶 on 2014/02/22.
//  Copyright (c) 2014年 大崎 瑶. All rights reserved.
//

#import "MmonViewController.h"
#import "MmonAppDelegate.h"

@interface MmonViewController ()

@end

@implementation MmonViewController

NSMutableArray *items;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    MmonAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = self;

    self.player = [MPMusicPlayerController iPodMusicPlayer];
    [[NSNotificationCenter defaultCenter] addObserver: self
         selector: @selector(onNowPlayingItemChanged)
         name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
         object: self.player];

    [self.player beginGeneratingPlaybackNotifications];
    
    items = [[NSMutableArray alloc] init];
    
    self.table.dataSource = self;
    self.table.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onNowPlayingItemChanged {
    NSLog(@"NowPlayingItemChanged");
    [self refreshTitle];
    
}

- (IBAction)onGetPushed:(id)sender {
    [self refreshTitle];
}

- (void)refreshTitle {
    MPMediaItem *nowPlayingItem = [self.player nowPlayingItem];
    //NSString *artist = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
    NSString *title  = [nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
    
    self.label.text = title;
    [items addObject:title];
    
    NSLog(@"refresh: %@", title);

    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView
         numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    
    return cell;
}

@end
