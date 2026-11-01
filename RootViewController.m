#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIApplicationDelegate> {
    // We cache the images permanently in variables so the app never recreates them on tap
    UIImage *monkeyImg;
    UIImage *textImg;
}
@property (nonatomic, assign) BOOL showingMonkey;
@property (nonatomic, retain) UIImageView *fullScreenView;
@property (nonatomic, retain) UIWindow *window;
@end

@implementation RootViewController

@synthesize showingMonkey = _showingMonkey;
@synthesize fullScreenView = _fullScreenView;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([self.window respondsToSelector:@selector(setRootViewController:)]) {
        self.window.rootViewController = self;
    } else {
        [self.window addSubview:self.view];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.showingMonkey = YES;
    

    monkeyImg = [[UIImage imageNamed:@"monkey.png"] retain];
    textImg = [[UIImage imageNamed:@"text.png"] retain];
    

    self.fullScreenView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.fullScreenView.center = self.view.center;
    self.fullScreenView.image = monkeyImg;
    self.fullScreenView.contentMode = UIViewContentModeScaleAspectFit;
    self.fullScreenView.userInteractionEnabled = YES;
    [self.view addSubview:self.fullScreenView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Wrap the swap logic inside a localized autorelease loop to protect iDared's memory state
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    if (self.showingMonkey) {
        self.fullScreenView.image = textImg;
        self.showingMonkey = NO;
    } else {
        self.fullScreenView.image = monkeyImg;
        self.showingMonkey = YES;
    }
    
    [pool release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc {
    [monkeyImg release];
    [textImg release];
    [_fullScreenView release];
    [_window release];
    [super dealloc];
}

@end

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"RootViewController");
    [pool release];
    return retVal;
}
