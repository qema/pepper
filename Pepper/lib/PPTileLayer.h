//
//  PPTileLayer.h
//  Pepper
//
//  Created by Andrew Wang on 6/13/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPLayer.h"
#import "PPTileMap.h"

/** Manages/draws a tile map */
@interface PPTileLayer : PPLayer

@property (nonatomic,retain) PPTileMap *tileMap;

-(id)initWithFrame:(CGRect)frame tileMap:(PPTileMap *)tileMap;
@end
