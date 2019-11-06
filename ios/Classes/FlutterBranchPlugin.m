#import "FlutterBranchPlugin.h"
#import <flutter_branch/flutter_branch-Swift.h>

@implementation FlutterBranchPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterBranchPlugin registerWithRegistrar:registrar];
}
@end
