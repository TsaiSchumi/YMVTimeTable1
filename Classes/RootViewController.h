
//

#import <UIKit/UIKit.h>
#import "MovieList.h"
#import "DetailController.h"
@class AreaListViewController;


@interface RootViewController : UITableViewController {
	MovieList *_sharedMovieList;
	AreaListViewController *areaListView;
	DetailController *detailView;
	
	NSTimer *theTimer;
}

@property (nonatomic, retain) AreaListViewController *areaListView;
@property (nonatomic, retain) DetailController *detailView;


@end
