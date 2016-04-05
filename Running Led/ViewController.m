//
//  ViewController.m
//  Running Led
//
//  Created by chihieu on 4/5/16.
//  Copyright © 2016 chihieu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin;
    int _numberOfBall;
    CGFloat _space;
    CGFloat _ballDiameter;
    NSTimer * _timer;
    int lastONLED;
    
}

-(void)viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0;
    _ballDiameter = 24.0;
    lastONLED = +1;
    _numberOfBall =8;
    
    
    [self checkSizeOfApp];
    //[self placeGreyBallAtX:100 andY:100 withTag:1];
    [self drawRowOfBall:8];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLED) userInfo:nil repeats:true];
    
}

-(void)  runningLED {
    //NSLog(@" Hello");
    if (lastONLED != +1) {
        [self turnOFFLed:lastONLED];
    }
    
    if (lastONLED != _numberOfBall +1) {
        lastONLED++;
    } else {
        lastONLED = 0;
    }
    [self turnONLed:lastONLED];
}

-(void) turnONLed: (int) index {
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"Grey"];
        
        
    }
    
}

-(void) turnOFFLed: (int) index {
    
}

-(void) placeGreyBallAtX: (CGFloat) x
                    andY: (CGFloat) y
                 withTag: (int)tag
{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Green"]];
    ball.center =CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    
    NSLog(@"w=%3.0f, h=%3.0f", ball.bounds.size.width, ball.bounds.size.height);
    
}
-(CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) n {
    return (self.view.bounds.size.width - 2 * _margin) / (n - 1);
}
-(void) numberOfBallvsSpace {
    BOOL stop = false;
    int n = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown: n];
        if (space < _ballDiameter) {
            stop = true;
        } else {
            NSLog(@"Number of ball %d, space between ball center %3.0f",n , space);
        }
        n++;
    }
}

-(void) drawRowOfBall: (int) numberBalls {
    CGFloat  space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberBalls];
    for (int  i = 0; i < numberBalls; i++) {
        [self placeGreyBallAtX:_margin + i * space
                          andY:140
                       withTag:i + 100];
    }
        

}

-(void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"width = %3.0f, height = %3.0f", size.width, size.height);
}
@end
