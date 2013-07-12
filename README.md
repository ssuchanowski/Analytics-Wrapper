Analytics Wrapper
=================
Analytics Wrapper should in a way help you quickly add few (from many that are growing now) services that will gather either data or logs from your app. I am starting here with Google and Flurry for analytics and TestFlight for remote logging but I will add few more in the future.

Installation
=================
It's very easy - just add <tt>AnalyticsWrapper</tt> & <tt>ViewControllerWrapper</tt> to your project. After that you are just few changes away form complete, so:

- in <tt>AnalyticsWrapper.h</tt> uncomment and set the proper ID for services you want to use
- <tt>CONST_DISABLE_ANALYTICS</tt> is a bool which determines if any analytics should gather data, basically keep it <tt>YES</tt> on non-production builds
- if you are using Google Analytics then all your View Controllers should inherit from <tt>ViewControllerWrapper</tt>  instead of <tt> UIViewController</tt> , thanks to that you won't have to set name for each view - I have a habit of naming controllers with "VC" at the end so there is appropriate code in the class to remove this (change this according to your needs) and made the name more human ;)
- go to your .pch file and add:

```objective-c
#import "AnalyticsWrapper.h"
#import "ViewControllerWrapper.h"

#ifdef CONST_TEST_FLIGHT_ID
#define NSLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif
```
This will automatically create remote logs from every NSLog you used and it will be send to Test Flight if you are using it.

Usage
=================
In your <tt>AppDelegate.m</tt> class initialize AnalyticsWrapper in <tt>application:didFinishLaunchingWithOptions:</tt> method

```objective-c
// analytics
[AnalyticsWrapper setup];
```

Other possibilities:
- Set age

```objective-c
[AnalyticsWrapper setUserAge:21];
```
- Set gender

```objective-c
[AnalyticsWrapper setUserSex:YES]; // YES for male
```
- Set location

```objective-c
[AnalyticsWrapper setUserLocation:location]; // a CLLocation object
```
- Log timed events (Flurry enabled logging timed events but you have to point out start and stop for each view) -- I'll probably add this to <tt>ViewControllerWrapper</tt> in next version

```objective-c
// in viewDidAppear
[AnalyticsWrapper logEvent:@"Menu" timed:YES];

// in viewWillDisappear
[AnalyticsWrapper endTimedEvent:@"Menu"];
```
- Log exception (besides those - unhandled ones will be captured by Flurry)

```objective-c
[AnalyticsWrapper trackExceptionWithDescription:@"User is stupid! :)" fatal:YES];
```

Requirements
=================
Yep, not really ;) Strictly depends on the libraries.

License
=================
AnalyticsWrapper is available under the MIT license.

TODO
=================
- More comments
- More services
- Check if libs files are present
