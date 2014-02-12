

#import "DetailController.h"


@implementation DetailController


@synthesize caller ,imageView , textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	_sharedMovieList = [MovieList sharedMovieList];	

}

- (void)loadImage {
	NSURL *url   = [NSURL URLWithString:_sharedMovieList.selectedImgURL ];
    NSData *imgData = [NSData dataWithContentsOfURL:url ];
	img= [UIImage imageWithData: imgData ];
	[self performSelectorOnMainThread:@selector(loadImageWithOperation) withObject:nil waitUntilDone:YES];
	imageView.image=  img ;
    [[self view]setNeedsDisplay];
    //[imageView reloadInputViews];
}

- (void)loadImageWithOperation {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[tableView reloadData];
    [[self view]setNeedsDisplay];
    //[imageView reloadInputViews];
}


- (void)viewWillAppear:(BOOL)animated {
	if (caller == 2) {
		self.title = [[[_sharedMovieList NmovieList] objectAtIndex:[_sharedMovieList selectedMovie]] dataTitle];
	}
	else 
	{	self.title = [[[_sharedMovieList movieList] objectAtIndex:[_sharedMovieList selectedMovie]] dataTitle];
		
		
	}
	imageView.image = nil ;
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    [self loadImage];
	
	[tableView reloadData];
    [super viewWillAppear:animated];
	

	[textView setText:[_sharedMovieList selectedDetail ]];	
	[self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	labelTime.text = [_sharedMovieList ReleaseDate];
	if (caller==2) {
		labelLenght.text = @"未提供";
	}
	else {
		labelLenght.text = [_sharedMovieList MovieLength];
	}
	[imageView setNeedsDisplay];
    
    NSString* rate = [_sharedMovieList expected] ;
    if (rate && [rate length]>0) {
        [lableRated setText:rate];
    }
    else {
        [lableRated setText:@"Unrated"];
    }
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Add a title for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *title ;
	switch (section) {

	 case 0:
			title = @"簡評";
			break;
		default:
			title = @"";
			break;
	}
	return title ;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	if(self.caller==2){
		tView.allowsSelection = FALSE ;
	}
	else {
		tView.allowsSelection = TRUE ;
	}

    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	int row = [indexPath section];
	switch (row)
	{

		case 0:
		{
			[[cell textLabel] setText:[_sharedMovieList selectedDetail ]];
			[[cell textLabel] setNumberOfLines:200];
			[[cell textLabel] setFont:[[[cell textLabel] font] fontWithSize:12]];
			break;
		}
		default:
			break ;
	}
    // Set up the cell...
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return ;
}




//// Customize the height for each rows in the table view.
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//	CGFloat height ;
//	switch ([indexPath section]) {
//	
//		case 0:
//			height = [[_sharedMovieList selectedDetail ] length ] /2  ;
//			//NSLog(@"  ---  %d   ---",height);
//			break ;
//		default:
//			break;
//	}
//	return height ;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150 ;
}


- (void)dealloc {
    [super dealloc];
}


@end

