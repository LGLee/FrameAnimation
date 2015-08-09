//
//  ViewController.m
//  拳皇帧动画
//
//  Created by MacBookPro on 15/8/9.
//  Copyright © 2015年 sky5156. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

//拿到storyboard中的imageView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//放点音乐
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加个边框
    CALayer *layer = [self.imageView layer];
    layer.borderColor = [UIColor redColor].CGColor;
    layer.borderWidth = 5.0f;
    [self stand];
}
- (IBAction)stand {
    [self play:@"stand" count:10];
}

- (IBAction)dead {
    [self play:@"dead" count:23];
}

- (IBAction)run {
    [self play:@"run" count:6];
}

- (IBAction)xiaozhao {
    [self play:@"xiaozhao1" count:20];
    
    [self playMusic:@"xiaozhao1"];
    [self performSelector:@selector(xiaozhao2) withObject:nil afterDelay:20 * 0.06];
    
   // [self play:@"xiaozhao3" count:39];
}

- (IBAction)dazhao {
    [self play:@"dazhao" count:87];
    [self playMusic:@"dazhao"];
}

- (IBAction)install_b {
    [self play:@"install_b" count:29];
}


- (void)xiaozhao2
{
    [self play:@"xiaozhao2" count:35];
    [self playMusic:@"xiaozhao2"];
    [self performSelector:@selector(xiaozhao3) withObject:nil afterDelay:35 * 0.06];
}

-(void)xiaozhao3
{
    [self play:@"xiaozhao3" count:39];
    [self playMusic:@"xiaozhao3"];

}


- (void)playMusic:(NSString *)music
{
    
    NSString *urlString = [NSString stringWithFormat:@"%@",music];
  //  NSString *urlName = [[NSBundle mainBundle] pathForResource:urlString ofType:@"mp3"];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:urlString withExtension:@"mp3"];
    self.player= [AVPlayer playerWithURL:url];
    [self.player play];
}


- (void)play:(NSString *)preFixName count:(int)count
{
    //加载动画
    NSMutableArray *images = [NSMutableArray array];
    
    for (int i = 1; i<=count; i++) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@_%d",preFixName,i];
        
        NSString *name = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        
        UIImage *image = [UIImage imageWithContentsOfFile:name];
        
        [images addObject:image];
    }
    //设置动画的
    self.imageView.animationImages = images;
    
    self.imageView.image = [UIImage imageNamed:@"stand_1"];
    
    self.imageView.animationRepeatCount = [preFixName isEqualToString:@"stand"]?0 : 1;
    
    self.imageView.animationDuration = count*0.06;
    
    [self.imageView startAnimating];
    
    
    //播放完以后站着
    if ([preFixName isEqualToString:@"stand"])  return;
    
    [self performSelector:@selector(stand) withObject:nil afterDelay:count *0.06];
}



@end
