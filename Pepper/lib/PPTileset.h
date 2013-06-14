//
//  PPTileset.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTextureAtlas.h"
#import "ppTypes.h"

/** Tileset that stores tile info/properties and gives tile quads */
@interface PPTileset : PPTextureAtlas <NSXMLParserDelegate>
{
    NSDictionary *tilesetDict;
    int firstGID;
}

/** Size of each tile */
@property (nonatomic) CGSize tileSize;
@property (nonatomic,retain) NSString *name;
@property (nonatomic) float spacing;
@property (nonatomic) float margin;

-(id)initWithImageFile:(NSString *)file properties:(NSDictionary *)dict scale:(float)scale;

-(Quad)quadForTile:(int)tileID;
-(Quad)normalizedQuadForTile:(int)tileID;
-(NSDictionary *)propertiesForTile:(int)tileID;
@end
