

#import <UIKit/UIKit.h>

@class RootViewController;
@class MovieList;

@interface MainMenuViewController : UIViewController {
	MovieList *_sharedMovieList;

	RootViewController *rootView;
	IBOutlet UIButton *buttonNew ;
	IBOutlet UIButton *buttonOld ;
	IBOutlet UIActivityIndicatorView *activityInd;
	UIActionSheet *theSheet;

	NSTimer *theTimer;
}

@property (nonatomic, retain) RootViewController *rootView;
@property (nonatomic, retain)  UIButton *buttonNew ;
@property (nonatomic, retain)  UIButton *buttonOld ;

- (IBAction)releasedMV:(id)sender;


@end
