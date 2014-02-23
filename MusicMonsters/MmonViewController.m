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

MmonAppDelegate *appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    appDelegate = [[UIApplication sharedApplication] delegate];

    self.player = [MPMusicPlayerController iPodMusicPlayer];
    [[NSNotificationCenter defaultCenter] addObserver: self
         selector: @selector(onNowPlayingItemChanged)
         name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
         object: self.player];

    [self.player beginGeneratingPlaybackNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:@"applicationDidBecomeActive"
                                               object:nil];
    
    self.table.dataSource = self;
    self.table.delegate = self;

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"applicationDidBecomeActive" object:nil];
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

- (void)applicationDidBecomeActive {
    NSLog(@"applicationDidBecomeActive");
    [self.table reloadData];
}

- (void)refreshTitle {
    MPMediaItem *nowPlayingItem = [self.player nowPlayingItem];
    //NSString *artist = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
    NSString *title  = [nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
    
    if (![appDelegate.current isEqualToString:title]) {
        appDelegate.current = title;
        self.label.text = title;
        [appDelegate.items addObject:title];
        [self.table reloadData];
    }
    
    NSLog(@"refresh: %@", title);
}

- (NSInteger)tableView:(UITableView *)tableView
         numberOfRowsInSection:(NSInteger)section
{
    return [appDelegate.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.text = [appDelegate.items objectAtIndex:indexPath.row];
    
    return cell;
}

@end
