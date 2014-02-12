

#import "MainMenuViewController.h"
#import "RootViewController.h"
#import "MovieList.h"

@implementation MainMenuViewController

@synthesize rootView;
@synthesize buttonNew ;
@synthesize buttonOld ;


- (IBAction)releasedMV:(id)sender {
	
	if ([UIApplication sharedApplication].networkActivityIndicatorVisible==YES) {
		return ;
	}
	else {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		
		[activityInd startAnimating];
		
		NSOperationQueue *queue = [NSOperationQueue new];
		
		NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																				selector:@selector(startFetchingMVList)
																				  object:nil];
		
		[queue addOperation:operation];
		[operation release];
	}
}

- (void)startFetchingMVList {
	_sharedMovieList = [MovieList sharedMovieList];
	if ([[_sharedMovieList movieList] count] == 0)
		[_sharedMovieList fetchMovieList];
	
	[self performSelectorOnMainThread:@selector(gotoReleasedMV) withObject:nil waitUntilDone:YES];
	
}

- (void)gotoReleasedMV {
	if (self.rootView == nil) {
		RootViewController *viewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
		self.rootView = viewController;
		[viewController release];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible=NO ;
	[self.navigationController pushViewController:self.rootView animated:YES];
	
}



- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:YES];
	[self setTitle:@"返回"];
}


- (void)viewDidDisappear:(BOOL)animated {
	[activityInd stopAnimating];

	[super viewDidDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
