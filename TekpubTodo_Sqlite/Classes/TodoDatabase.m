//
//  TodoDatabase.m
//  TekpubTodo
//
//  Created by Ben Scheirman on 5/15/10.
//  Copyright 2010 ChaiONE. All rights reserved.
//

#import "TodoDatabase.h"
#import "FileHelpers.h"
#import <sqlite3.h>
#import "Todo.h"

NSString *DATABASE_FILENAME = @"todo.db";

@implementation TodoDatabase

+(void)makeWritableDatabase {
	
	NSString *targetPath = [DocumentsDirectory() 
							   stringByAppendingPathComponent:DATABASE_FILENAME];
	
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	if([fileMgr fileExistsAtPath:targetPath]) {
		NSLog(@"File already exists in documents directory.");
		return;
	}
	
	NSString *sourcePath = PathForResource(DATABASE_FILENAME);
	[fileMgr copyItemAtPath:sourcePath toPath:targetPath error:nil];
	NSLog(@"Copied %@ from bundle path to documents directory.", DATABASE_FILENAME);
}

-(NSString *)dbPath {
	return [DocumentsDirectory() stringByAppendingPathComponent:DATABASE_FILENAME];
}

-(sqlite3 *)openDatabase {
	sqlite3 *db;
	int status = sqlite3_open([[self dbPath] UTF8String], &db);
	if (status != SQLITE_OK) {
		NSLog(@"ERROR OPENING DATABASE!");
		exit(1);
	}
	
	return db;
}

-(sqlite3_stmt *)prepareStatement:(const char *)sql forDb:(sqlite3 *)db {
	sqlite3_stmt *stmt;
	int status = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
	
	if (status != SQLITE_OK) {
		NSLog(@"ERROR PREPARING STATEMENT:  %s", sqlite3_errmsg(db));
		exit(1);
	}
	
	return stmt;
}

-(NSArray *)fetchTodos {
	
	sqlite3 *db = [self openDatabase];
	
	sqlite3_stmt *stmt = [self prepareStatement:"SELECT id, text, completed FROM todos;" forDb:db];
	
	NSMutableArray *todos = [[NSMutableArray alloc] init];
	while (sqlite3_step(stmt) == SQLITE_ROW) {
		NSLog(@"Processing row...");
		Todo *todo = [[Todo alloc] init];
		todo.todoId = sqlite3_column_int(stmt, 0);
		todo.text = [NSString stringWithFormat:@"%s", sqlite3_column_text(stmt, 1)];
		todo.completed = [[NSNumber numberWithInt:sqlite3_column_int(stmt, 2)] boolValue];
		[todos addObject:todo];
	}

	sqlite3_finalize(stmt);
	sqlite3_close(db);
	
	return [todos autorelease];
}


-(void)updateTodo:(Todo *)todo {
	sqlite3 *db = [self openDatabase];
	sqlite3_stmt *stmt = [self prepareStatement:"UPDATE todos SET text = ?, completed = ? WHERE id = ?" forDb:db];
	
	sqlite3_bind_text(stmt, 1, [todo.text UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(stmt, 2, todo.completed);
	sqlite3_bind_int(stmt, 3, todo.todoId);
	
	int result = sqlite3_step(stmt);
	
	if (result != SQLITE_DONE) {
		NSLog(@"An Error occurred while updating the todo!  %s", sqlite3_errmsg(db));
		exit(1);
	}
	
	sqlite3_finalize(stmt);
	sqlite3_close(db);
}

-(int)lastInsertedIdForDb:(sqlite3 *)db {
	sqlite3_stmt *stmt = [self prepareStatement:"SELECT last_insert_rowid()" forDb:db];
	sqlite3_step(stmt);
	int rowid = sqlite3_column_int(stmt, 0);
	sqlite3_finalize(stmt);
	
	return rowid;
}

-(void)insertTodo:(Todo *)todo {
	sqlite3 *db = [self openDatabase];
	sqlite3_stmt *stmt = [self prepareStatement:"INSERT INTO todos(text, completed) VALUES(?, ?);" forDb:db];
	
	sqlite3_bind_text(stmt, 1, [todo.text UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(stmt, 2, todo.completed);
	
	int result = sqlite3_step(stmt);
	
	if (result != SQLITE_DONE) {
		NSLog(@"An Error occurred while inserting the todo!  %s", sqlite3_errmsg(db));
		exit(1);
	}
	
	//get the primary key
	todo.todoId = [self lastInsertedIdForDb:db];
	
	sqlite3_finalize(stmt);
	sqlite3_close(db);	
}


-(void)deleteTodo:(Todo *)todo {
	sqlite3 *db = [self openDatabase];
	sqlite3_stmt *stmt = [self prepareStatement:"DELETE FROM todos WHERE id= ?;" forDb:db];
	
	sqlite3_bind_int(stmt, 1, todo.todoId);
	
	int result = sqlite3_step(stmt);
	
	if (result != SQLITE_DONE) {
		NSLog(@"An Error occurred while deleting the todo!  %s", sqlite3_errmsg(db));
		exit(1);
	}

	sqlite3_finalize(stmt);
	sqlite3_close(db);
}


@end
