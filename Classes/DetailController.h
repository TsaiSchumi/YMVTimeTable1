

#import <UIKit/UIKit.h>
#import "MovieList.h"

//@interface DetailController : UITableViewController {
@interface DetailController : UIViewController {	
	MovieList *_sharedMovieList;
	NSInteger caller ;
	UIImage *img;
	//////////////////////  add on 0504
	IBOutlet UIImageView    *imageView ;
	IBOutlet UILabel		*labelLenght ;
	IBOutlet UILabel		*labelActor ;
	IBOutlet UILabel		*labelTime ;
	IBOutlet UITableView    *tableView ;
	IBOutlet UITextView     *textView ;
    IBOutlet UILabel        *lableRated ;
	
}
@property (nonatomic) NSInteger  caller ;
//@property (nonatomic,retain) UITableView * tableView ;
@property (nonatomic,retain) UIImageView * imageView ;
@property (nonatomic,retain) UITextView	* textView ;

@end


