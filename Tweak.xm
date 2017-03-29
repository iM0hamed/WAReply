%group MOD
%hook UIDevice
-(NSString*)systemVersion{
	if ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"net.whatsapp.WhatsApp"])
		return @"9.1";
	else return %orig;
}
%end
%end

%group MIC
static BOOL first = YES;
%hook WAChatBar
-(void)pttButtonInsideReleased:(id)released withEvent:(id)event{
	if(!first){
		first = YES;
		%orig;
	}
	else
		first = NO;
}
-(void)pttButtonPressed:(id)pressed withEvent:(id)event{
	if(first)
		%orig;
}

%end
%end

static void PreferencesCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	CFPreferencesAppSynchronize(CFSTR("com.joemerlino.wareply"));
}

%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PreferencesCallback, CFSTR("com.joemerlino.wareply.preferencechanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.joemerlino.wareply.plist"];
	BOOL mic = ([prefs objectForKey:@"mic"] ? [[prefs objectForKey:@"mic"] boolValue] : NO);
	if([[[UIDevice currentDevice] systemVersion] floatValue] < 9.1)
    	%init(MOD);
    if (mic)
    	%init(MIC);
}