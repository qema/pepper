//
//  PPTMXParser.h
//  Pepper
//
//  Created by Andrew Wang on 6/13/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPObject.h"

typedef enum {
    tmxParseNormal,
    tmxParseExternalTileset
} TMXParseOptions;

typedef enum {
    tmxBlockNone,
    tmxBlockMapData,
    tmxBlockTileset,
    tmxBlockTile,
    tmxBlockLayer
} TMXBlockName;

@interface PPTMXParser : PPObject <NSXMLParserDelegate>
{
    TMXBlockName currentBlock;
    int currentTileID;
    int currentLayer;
    NSString *dataEncoding;
    NSString *dataCompression;
    TMXParseOptions parseOptions;
    NSMutableDictionary *tileProperties;
}

@property (nonatomic,strong) NSMutableArray *layers;
@property (nonatomic) CGSize mapSize;
@property (nonatomic,strong) NSString *tilesetImageFile;
@property (nonatomic,strong) NSMutableDictionary *tilesetProperties;

-(id)initWithFile:(NSString *)file;
-(id)initWithFile:(NSString *)file options:(TMXParseOptions)options;

@end
