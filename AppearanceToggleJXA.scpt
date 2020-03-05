/*version 1.0.1
2020-02-28
Julio Toledo, Automation USA LLC
https://www.automationusa.net
switch Appearance in macOS Mojave, Catalina
by toggling Dark/Light mode and switching the corresponding wallpaper*/

//toggle this value to invoke user interaction list
var gui = false ; 

//set your preferred appearance here
var theChoice = ['Light Mode'];

var appSE = Application('System Events');
appSE.includeStandardAdditions = true;

var app = Application.currentApplication();
app.includeStandardAdditions = true;

function osVersion() {
	var os = app.systemInfo().systemVersion;
	return os;
}

function getDarkMode() {
	var bool = appSE.appearancePreferences.darkMode();
	return bool;
}

function setDarkMode(bool) {
	if ( bool == false) {
		appSE.appearancePreferences.darkMode = false;
	}
	else if (bool == true) {
		appSE.appearancePreferences.darkMode = true;		
	}
}

function switchWallpaper(bool) {
	if ( bool == false ) {
		if ( osVersion().includes('10.14') ) {
			var myOS = 'mojave';
			var wallPaper = '/Library/Desktop Pictures/Mojave Day.jpg';
		}
		else if (osVersion().includes('10.15') ){
			var myOS = 'catalina';
			var wallPaper = '/System/Library/Desktop Pictures/Catalina Day.heic';
		}
		if ( myOS == 'mojave') {
			appSE.currentDesktop.picture = wallPaper;
		}
	}
	else if ( bool == true ) {
		if ( osVersion().includes('10.14') ) {
			var myOS = 'mojave';
			var wallPaper = '/Library/Desktop Pictures/Mojave Night.jpg';
		}
		else if (osVersion().includes('10.15') ){
			var myOS = 'catalina';
			var wallPaper = '/System/Library/Desktop Pictures/Catalina Night.heic';
		}
		if ( myOS == 'mojave') {
			appSE.currentDesktop.picture = wallPaper;
		}
	}
}

function confirmChoice (gui, theChoice) {
	if (gui == true ) 
	{
		try {
			var pickList = app.chooseFromList (
				['Dark Mode', 'Light Mode'], 
				{ withTitle: 'Appearance Toggle:' } , 
				{ withPrompt: 'Switch to:' , multipleSelectionsAllowed: false } 
			);
			}
			catch (e) {
				return 'error ' + e;
			}
			if ( pickList == 'Dark Mode' ) {
				var theChoice = true ;
			}
			else if ( pickList == 'Light Mode' ) {
				var theChoice = false ;
			}
	}
	return theChoice;
}

function theDefault()
{
	if (appSE.appearancePreferences.darkMode() == true ) {
		return false;
	}
	else {
		return true;
	}
}

//methodMain
if ( osVersion().includes('10.14') || osVersion().includes('10.15') ) {
	if ( gui == false ) {
	
		if ( theDefault() == false )
		{
			//switch to light mode
			if ( getDarkMode() == true ) {
				setDarkMode(false);
				switchWallpaper(false);				
				app.displayNotification (
					'Appearance switched to "Light"',
					{ withTitle: 'Appearance Toggle', subtitle: 'Done!' }
				)
			}
		}
		else if ( theDefault() == true ) {
			//switch to dark mode
			if ( getDarkMode() == false ) {
				setDarkMode(true);
				switchWallpaper (true);
				app.displayNotification (
					'Appearance switched to "Dark"',
					{ withTitle: 'Appearance Toggle', subtitle: 'Done!' }
				)
			}
		}
	}
	else {
		var selection = confirmChoice(gui, theChoice);
		if (  selection == false ) {
			//switch to light mode
			if ( getDarkMode() == true ) {
				setDarkMode(false);
				switchWallpaper(false);
				app.displayNotification (
					'Appearance switched to "Light"',
					{ withTitle: 'Appearance Toggle', subtitle: 'Done!' }
				)
			}
		}
		else if (selection == true ) {
			//switch to dark mode
			if ( getDarkMode() == false ) {
				setDarkMode(false);
				switchWallpaper(true);
				app.displayNotification (
					'Appearance switched to "Dark"',
					{ withTitle: 'Appearance Toggle', subtitle: 'Done!' }
				)
			}
		}
	}
}
