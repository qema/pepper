//
//  PPViewController.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPViewController.h"

@interface PPViewController ()

@end

@implementation PPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init GL context
    glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *view = [[GLKView alloc] initWithFrame:self.view.frame context:glContext];
    self.view = view;
    [EAGLContext setCurrentContext:glContext];
    
    // setup GL
    glClearColor(0, 0, 0, 1);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    // setup engine
    _engine = [[PPEngine alloc] init];
    self.delegate = _engine;
}

-(CGRect)normalizedFrame
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        CGRect frame;
        frame.origin.x = self.view.frame.origin.y;
        frame.origin.y = self.view.frame.origin.x;
        frame.size.width = self.view.frame.size.height;
        frame.size.height = self.view.frame.size.width;
        return frame;
    } else {
        return self.view.frame;
    }
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.engine renderStage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
