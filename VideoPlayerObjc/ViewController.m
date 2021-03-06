//
//  ViewController.m
//  VideoPlayerObjc
//
//  Created by Abdullah on 20/10/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self play];
    [self playOptionTwo];
}

/**
 Play a video on UIView
 */
- (void) play {
    
    NSString *filepath = [[NSBundle mainBundle]
                          pathForResource:@"testVid"
                          ofType:@"mp4"
                          inDirectory:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    
    AVPlayer *player = [AVPlayer playerWithURL:fileURL];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    AVPlayerViewController *playerController = AVPlayerViewController.new;
    
    [self presentViewController:playerController animated:YES completion:^{
        [player play];
    }];
    
    playerController.player = player;
    playerController.showsPlaybackControls = NO;
    playerController.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerController.view.frame = self.view.bounds;
    [self.view addSubview:playerController.view];
    
    [playerController.player play];
    [self loopVideo:player];
}

- (void) playOptionTwo {
    NSString *filepath = [[NSBundle mainBundle]
                          pathForResource:@"testVid"
                          ofType:@"mp4"
                          inDirectory:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    self.avPlayer = [AVPlayer playerWithURL:fileURL];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    videoLayer.frame = self.view.bounds;
    videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:videoLayer];
    
    [self.avPlayer play];
    [self loopVideo:self.avPlayer];
}

/**
 Making the video non-stop

 @param videoPlayer AVPlyer object
 */
- (void) loopVideo:(AVPlayer*)videoPlayer {
    [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [videoPlayer seekToTime:kCMTimeZero];
        [videoPlayer play];
    }];
}
@end
