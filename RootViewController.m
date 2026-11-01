#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIApplicationDelegate>
@property (nonatomic, assign) BOOL showingMonkey;
@property (nonatomic, retain) UIImageView *fullScreenView;
@property (nonatomic, retain) UIWindow *window;
@end

@implementation RootViewController

@synthesize showingMonkey = _showingMonkey;
@synthesize fullScreenView = _fullScreenView;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Force the status bar hidden to ensure a pure full-screen arcade viewport layout
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
    
    // ORIENTATION FIX:
    // Because touchHLE handles window boundaries as a vertical stack, we bind the view boundaries
    // to the native screen bounds dynamically so the OS forces it to fit landscape layouts perfectly!
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.fullScreenView = [[UIImageView alloc] initWithFrame:screenBounds];
    self.fullScreenView.image = [UIImage imageNamed:@"monkey.png"];
    self.fullScreenView.contentMode = UIViewContentModeScaleToFill;
    self.fullScreenView.userInteractionEnabled = YES;
    [self.view addSubview:self.fullScreenView];
}

// 🚀 THE EMULATOR CRASH FIX: Pure iOS 2.0 raw frame-swapping tap detection
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.showingMonkey) {
        [self.fullScreenView setImage:[UIImage imageNamed:@"text.png"]];
        self.showingMonkey = NO;
    } else {
        [self.fullScreenView setImage:[UIImage imageNamed:@"monkey.png"]];
        self.showingMonkey = YES;
    }
}

// Vintage rotation support flags for iPhone OS 2/3 devices
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

// iOS 6+ rotation fallback mapping configuration routines
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (void)dealloc {
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
