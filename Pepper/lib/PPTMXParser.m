//
//  PPTMXParser.m
//  Pepper
//
//  Created by Andrew Wang on 6/13/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTMXParser.h"
#import "PPFileUtils.h"
#import "NSData+Base64.h"

@implementation PPTMXParser

-(id)initWithFile:(NSString *)file options:(TMXParseOptions)options
{
    if (self=[super init]) {
        parseOptions = options;
        self.layers = [[NSMutableArray alloc] initWithCapacity:2];
        tileProperties = [[NSMutableDictionary alloc] initWithCapacity:20];
        self.tilesetProperties = [[NSMutableDictionary alloc] initWithCapacity:16];
        currentBlock = tmxBlockNone;
        currentLayer = -1;
        
        // parse the TMX file
        NSData *data = [NSData dataWithContentsOfFile:[PPFileUtils fullPath:file]];
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        parser.delegate = self;
        if (![parser parse])
            NSLog(@"Error: failed to load TMX file %@",file);
        
        // add tile properties to main dictionary under key "tiles"
        [self.tilesetProperties addEntriesFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:tileProperties, @"tiles", nil]];
    }
    return self;
}

-(id)initWithFile:(NSString *)file
{
    return [self initWithFile:file options:tmxParseNormal];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (currentBlock == tmxBlockMapData) {
        // decode map data
        if ([dataEncoding isEqualToString:@"base64"]) {
            NSData *decoded = [NSData dataFromBase64String:string];
            if (!dataCompression) {
            } else if ([dataCompression isEqualToString:@"zlib"]) {
                NSLog(@"Error: unsupported map compression format");
            } else {
                NSLog(@"Error: unsupported map compression format");
            }
            [[self.layers objectAtIndex:currentLayer] setObject:decoded forKey:@"data"];
        } else {
            NSLog(@"Error: unsupported map data format");
        }
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"map"]) {
        int width = [[attributeDict objectForKey:@"width"] intValue];
        int height = [[attributeDict objectForKey:@"height"] intValue];
        self.mapSize = CGSizeMake(width, height);
    } else if ([elementName isEqualToString:@"tileset"]) {
        NSString *source = [attributeDict objectForKey:@"source"];
        if (source) {   // external tileset
            PPTMXParser *parser = [[PPTMXParser alloc] initWithFile:source options:tmxParseExternalTileset];
            self.tilesetImageFile = [parser.tilesetImageFile copy];
            self.tilesetProperties = [parser.tilesetProperties copy];
        }
        [self.tilesetProperties addEntriesFromDictionary:attributeDict];
        currentBlock = tmxBlockTileset;
    } else if ([elementName isEqualToString:@"layer"]) {
        currentLayer++;
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary: attributeDict];
        [dict addEntriesFromDictionary:attributeDict];
        [self.layers addObject:dict];
        currentBlock = tmxBlockLayer;
    } else if ([elementName isEqualToString:@"data"]) {
        if (parseOptions == tmxParseNormal) {
            dataEncoding = [attributeDict objectForKey:@"encoding"];
            dataCompression = [attributeDict objectForKey:@"compression"];
            currentBlock = tmxBlockMapData;
        }
    } else if ([elementName isEqualToString:@"image"]) {
        if (currentBlock == tmxBlockTileset) {  // image here refers to tileset image
            NSString *source = [attributeDict objectForKey:@"source"];
            self.tilesetImageFile = [source lastPathComponent];
            [self.tilesetProperties addEntriesFromDictionary:attributeDict];
        } else {
            NSLog(@"Error: TMX images unsupported");
        }
    } else if ([elementName isEqualToString:@"tile"]) {
        currentTileID = [[attributeDict objectForKey:@"id"] intValue];
        currentBlock = tmxBlockTile;
    } else if ([elementName isEqualToString:@"property"]) {
        if (currentBlock == tmxBlockTileset) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[attributeDict objectForKey:@"value"],[attributeDict objectForKey:@"name"], nil];
            [self.tilesetProperties addEntriesFromDictionary:dict];
        } else if (currentBlock == tmxBlockTile) {
            [tileProperties setObject:attributeDict forKey:[NSNumber numberWithInt:currentTileID]];
        } else if (currentBlock == tmxBlockLayer) {
            [[self.layers objectAtIndex:currentLayer] setObject:[attributeDict objectForKey:@"value"] forKey:[attributeDict objectForKey:@"name"]];
        } else {
            NSLog(@"Oops, forgot to implement property retrieve for this obj");
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (![elementName isEqualToString:@"property"] &&
        ![elementName isEqualToString:@"properties"])
        currentBlock = tmxBlockNone;
}
@end
