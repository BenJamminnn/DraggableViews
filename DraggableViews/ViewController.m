//
//  ViewController.m
//  DraggableViews
//
//  Created by Mac Admin on 5/14/15.
//  Copyright (c) 2015 BG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFour;
@property (nonatomic) BOOL hasView;
@property (strong, nonatomic) NSArray *imageViewCollection;
@property (strong, nonatomic) UIImageView *viewToDrag;
@property (weak, nonatomic) IBOutlet UIImageView *destinationView;
@property (nonatomic) NSUInteger destinationViewCounter;
@property (nonatomic) CGPoint originalLocation;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageViewCollection = @[_imageViewOne, _imageViewTwo, _imageViewThree, _imageViewFour];
    self.view.multipleTouchEnabled = NO;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    for(UIImageView *view in _imageViewCollection) {
        if(CGRectContainsPoint(view.frame, touchLocation)) {
            self.originalLocation = view.center;
            self.viewToDrag = view;
            self.hasView = YES;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.hasView) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchLocation = [touch locationInView:self.view];
        self.viewToDrag.center = touchLocation;
        [self.view bringSubviewToFront:self.viewToDrag];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(CGRectIntersectsRect(self.destinationView.frame, self.viewToDrag.frame)) {
        self.viewToDrag.center = self.originalLocation;
        self.destinationViewCounter++;
        self.viewToDrag = nil;
        if(self.destinationViewCounter > 4) {
            self.destinationViewCounter = 0;
        }
        self.destinationView.image = [self imageForNumber:self.destinationViewCounter];
    }
    self.viewToDrag.center = self.originalLocation;
    self.hasView = NO;
}

- (UIImage *)imageForNumber:(NSUInteger)number {
    UIImage *image;
    switch (number) {
        case 0:
            image = [UIImage imageNamed:@"orange-zero-hi"];
            break;
        case 1:
            image = [UIImage imageNamed:@"one"];
            break;
        case 2:
            image = [UIImage imageNamed:@"two"];
            break;
        case 3:
            image = [UIImage imageNamed:@"three"];
            break;
        case 4:
            image = [UIImage imageNamed:@"four"];
            break;
        default:
            break;
    }
    return image;
}

@end
