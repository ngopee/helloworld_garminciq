//import Toybox.Graphics;
//import Toybox.Lang;
//import Toybox.System;
//import Toybox.WatchUi;

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

using Toybox.Time.Gregorian as Date;
using Toybox.Application as App;

using Toybox.ActivityMonitor as ActMon;

class hellowfView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        setClockDisplay();
        setDateDisplay();
        setBatteryDisplay();
        setStepCountDisplay();
        setStepGoalDisplay();
        //setNotificationCountDisplay();
        setHeartrateDisplay();

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    private function setClockDisplay() {
    	var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
	
	    // This	will break if it doesn't match your drawable's id!
        var view = View.findDrawableById("TimeDisplay");
	
        view.setText(timeString);
    }

    hidden function setDateDisplay(){
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_LONG);
        var dateString = Lang.format("$1$ $2$, $3$", [date.month, date.day, date.year]);
        var dateDisplay = View.findDrawableById("DateDisplay");      
	    dateDisplay.setText(dateString);
    }

    hidden function setBatteryDisplay() {
        var battery = Sys.getSystemStats().battery;				
	    var batteryDisplay = View.findDrawableById("BatteryDisplay");      
	    batteryDisplay.setText(battery.format("%d")+"%");	
    }

    hidden function setStepCountDisplay() {
    	var stepCount = ActMon.getInfo().steps.toString();		
	    var stepCountDisplay = View.findDrawableById("StepCountDisplay");      
	    stepCountDisplay.setText(stepCount);		
    }

    hidden function setStepGoalDisplay() {
    	var stepGoalPercent = ((ActMon.getInfo().steps).toFloat() / (ActMon.getInfo().stepGoal).toFloat() * 100f);
	    var stepGoalDisplay = View.findDrawableById("StepGoalDisplay");      
	    stepGoalDisplay.setText(stepGoalPercent.format( "%d" ) + "%");	
    }

    hidden function setNotificationCountDisplay() {
    	var notificationAmount = Sys.getDeviceSettings().notificationCount;
		
        var formattedNotificationAmount = "";

        if(notificationAmount > 10)	{
            formattedNotificationAmount = "10+";
        }
        else {
            formattedNotificationAmount = notificationAmount.format("%d");
            //Sys.println( formattedNotificationAmount instanceof Lang.String);
        }

        var notificationCountDisplay = View.findDrawableById("MessageCountDisplay");      
        notificationCountDisplay.setText(formattedNotificationAmount);
    }

    hidden function setHeartrateDisplay() {
    	var heartRate = "";
    	
    	if(ActMon has :INVALID_HR_SAMPLE) {
    		heartRate = retrieveHeartrateText();
    	}
    	else {
    		heartRate = "";
    	}
    	
	    var heartrateDisplay = View.findDrawableById("HeartrateDisplay");      
	    heartrateDisplay.setText(heartRate);
    }

    private function retrieveHeartrateText() {
    	var heartrateIterator = ActivityMonitor.getHeartRateHistory(null, false);
	    var currentHeartrate = heartrateIterator.next().heartRate;

        if(currentHeartrate == ActMon.INVALID_HR_SAMPLE) {
            return "";
        }		

        return currentHeartrate.format("%d");
    }

}
