//___FILEHEADER___

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAMEASIDENTIFIER___ ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

#pragma mark - LifeCycle

- (void)dealloc {
#if DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

#pragma mark - Public Methods

#pragma mark - Actions

#pragma mark - Delegate

#pragma mark - Http && DB

#pragma mark - Private Methods

- (void)setupUI {
    self.title = @"";
}

#pragma mark - Getter && Setter

@end
