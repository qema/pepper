//
//  ViewController.m
//  Pepper
//
//  Created by Andrew Wang on 6/6/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "ViewController.h"
#import "TestStage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    glClearColor(0, 0.5, 0.5, 1);
    TestStage *stage = [[TestStage alloc] initWithFrame:[self normalizedFrame]];
    [self.engine runWithStage:stage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
