//
//  TodoDatabase.h
//  TekpubTodo
//
//  Created by Ben Scheirman on 5/15/10.
//  Copyright 2010 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

@interface TodoDatabase : NSObject {

}

+(void)makeWritableDatabase;

-(NSString *)dbPath;
-(NSArray *)fetchTodos;
-(void)updateTodo:(Todo *)todo;
-(void)insertTodo:(Todo *)todo;
-(void)deleteTodo:(Todo *)todo;

@end
