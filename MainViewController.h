//
//  MainViewController.h
//  picStory11
//
//  Created by zanli on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditorViewController ;

@interface MainViewController : UIViewController {
	EditorViewController *editorViewController ;
	
}

@property (nonatomic, retain) EditorViewController *editorViewController ;


- (IBAction)showEditorView:(id)sender;


@end
