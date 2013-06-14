//
//  PPTileMap.h
//  Pepper
//
//  Created by Andrew Wang on 6/14/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPObject.h"
#import "PPTileset.h"
#import "PPStageElement.h"

/** Stores a TMX map, including its tile and object layers */
@interface PPTileMap : PPStageElement
{
    CGSize size;
}

@property (nonatomic,retain) NSMutableArray *layers;
@property (nonatomic,retain) PPTileset *tileset;
-(id)initWithFile:(NSString *)file tilesetScale:(float)scale;
@end
