#import "iOSWifiConnect.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>  

@implementation iOSWifiConnect

- (void)connectNetwork:(CDVInvokedUrlCommand*)command {
	NSString* ssid = [command argumentAtIndex:0];
	NSString* password = [command argumentAtIndex:1];

	if (@available(iOS 11.0, *)) {
	    if (ssid && [ssid length]) {
			NEHotspotConfiguration *configuration = [[NEHotspotConfiguration
				alloc] initWithSSID:(NSString *)ssid 
					passphrase:(NSString *)password 
						isWEP:(BOOL)true;

			configuration.joinOnce = YES;
			[[NEHotspotConfigurationManager sharedManager] applyConfiguration:configuration completionHandler:nil];
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:ssid];
		} else {
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"SSID Not provided"];
		}
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"iOS 11+ not available"];
	}

    [self.commandDelegate sendPluginResult:pluginResult
                                callbackId:command.callbackId];
}

@end