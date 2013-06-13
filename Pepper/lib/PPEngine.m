//
//  PPEngine.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPEngine.h"

@implementation PPEngine

-(id)init
{
    if (self=[super init]) {
    }
    return self;
}

-(void)runWithStage:(PPStage *)stage
{
    self.stage = stage;
    [self.stage stageDidLoad];
}

-(void)glkViewControllerUpdate:(GLKViewController *)controller
{
    [self.stage update:controller.timeSinceLastUpdate];
}

-(void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause
{
}

-(void)renderStage
{
    [self.stage draw];
}
@end
