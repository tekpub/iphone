//
//  TekpubTodoViewController.h
//  TekpubTodo
//
//  Created by Ben Scheirman on 3/1/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoEditorController.h"
#import "Todo.h"
	
@interface TekpubTodoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TodoEditorDelegate> {
	UINavigationBar *navBar;
	NSMutableArray *todoItems;
	IBOutlet UITableView* _tableView;
	BOOL editing;
	Todo *lastEditedTodo;
}

-(IBAction)edit;
-(IBAction)addButtonPushed;

@end

