

#import "RootViewController.h"



@implementation RootViewController

@synthesize areaListView;
@synthesize detailView ;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	_sharedMovieList = [MovieList sharedMovieList];

	self.title = @"電影時刻表";
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	self.navigationController.navigationBarHidden = NO;
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[_sharedMovieList movieList] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
	UILabel *labelView = nil;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[[[cell subviews] objectAtIndex:0] setTag:111];
		
		labelView = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 330, 44)];
		[labelView setBackgroundColor:[UIColor clearColor]];
		[labelView setTag:222];
		[labelView setFont:[UIFont boldSystemFontOfSize:20]];
		[cell addSubview:labelView];
		[labelView release];
    }
	
	

	YMVData *movie = [[_sharedMovieList movieList] objectAtIndex:[indexPath row]];
	[(UILabel *)[cell viewWithTag:222] setText:[movie dataTitle]];
	
    return cell;
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([UIApplication sharedApplication].networkActivityIndicatorVisible==YES) {
			return ;
	}
	else {
		[_sharedMovieList setSelectedMovie:[indexPath row]];

		/* Operation Queue init (autorelease) */
		NSOperationQueue *queue = [NSOperationQueue new];
		
		/* Create our NSInvocationOperation to call loadDataWithOperation, passing in nil */
		NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																				selector:@selector(loadDetail)
																				  object:nil];
		
		/* Add the operation to the queue */
		[queue addOperation:operation];
		[operation release];
	}
}

- (void)loadDetail {
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [_sharedMovieList fetchDetail2:[[[ _sharedMovieList movieList ] objectAtIndex:[_sharedMovieList selectedMovie]] dataId ]];

    [self performSelectorOnMainThread:@selector(gotoDetail) withObject:nil waitUntilDone:YES];
}

- (void)gotoDetail {
	if (self.detailView == nil) {
		DetailController *viewController = [[DetailController alloc] initWithNibName:@"DetailViewController" bundle:nil];
		self.detailView = viewController;
		[viewController release];
	}
	
	detailView.caller= 1 ;

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	[self.navigationController pushViewController:self.detailView animated:YES];
}



- (void)dealloc {
    [super dealloc];
}


@end

