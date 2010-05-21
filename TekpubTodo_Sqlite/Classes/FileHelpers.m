//
//  FileHelpers.m
//  TekpubTodo
//
//  Created by Ben Scheirman on 5/15/10.
//  Copyright 2010 ChaiONE. All rights reserved.
//

#import "FileHelpers.h"

NSString* PathForResource(NSString *filename) {
	NSString *leftPart = [filename stringByDeletingPathExtension];
	NSString *extension = [filename pathExtension];
	return [[NSBundle mainBundle] pathForResource:leftPart ofType:extension];
}

NSString* DocumentsDirectory() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}