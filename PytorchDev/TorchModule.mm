#import "TorchModule.h"
#import <torch/script.h>

@implementation TorchModule {
 @protected
  torch::jit::script::Module _impl;
}

- (nullable instancetype)initWithFileAtPath:(NSString*)filePath {
  self = [super init];
  if (self) {
    try {
      auto qengines = at::globalContext().supportedQEngines();
      if (std::find(qengines.begin(), qengines.end(), at::QEngine::QNNPACK) != qengines.end()) {
        at::globalContext().setQEngine(at::QEngine::QNNPACK);
      }
      _impl = torch::jit::load(filePath.UTF8String);
      _impl.eval();
    } catch (const std::exception& exception) {
      NSLog(@"%s", exception.what());
      return nil;
    }
  }
  return self;
}


- (NSArray<NSNumber*>*)predictImage:(void*)imageBuffer {
  return nil;
}

@end

//[11.918683, -21.391111, -18.756794, -15.70252, -14.593732, 28.798603, -22.37965, 10.117706, 5.1135015, -8.376111, -25.258512, -7.270096, 0.9224758, 3.4262152, 28.566887, 2.90841, 25.247177, 35.124638, 14.7190695, -37.291008, -4.821145, 33.09956, 47.47553, 11.395653, 9.54897, -5.713372, -32.897644, -18.26301, -5.596691, -18.339537, -25.02614, -23.303043, -3.3603168, 31.69397, 3.0528922, 7.3663263]


