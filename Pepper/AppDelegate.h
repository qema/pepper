//
//  AppDelegate.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pepper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    PPEngine *engine;
}

@property (strong, nonatomic) UIWindow *window;

@end
