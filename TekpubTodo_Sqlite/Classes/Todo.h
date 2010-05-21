//
//  Todo.h
//  TekpubTodo
//
//  Created by Ben Scheirman on 3/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Todo : NSObject {
	int todoId;
	NSString *text;
	BOOL completed;
	NSDate *dateAdded;
}

@property (nonatomic) int todoId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic) BOOL completed;
@property (nonatomic, readonly) NSDate *dateAdded;

-(id)initWithText:(NSString *)text;

@end
