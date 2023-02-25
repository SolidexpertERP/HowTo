"use strict"

function initializeControlAddIn(id) 
{
    var controlAddIn = document.getElementById(id);

    controlAddIn.innerHTML =
		'' + '';
    pageLoaded();

	  Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady', null);
}

function pageLoaded() 
{

}

function UpdatePage() 
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('UpdateMyPage', null);
}
  
function CallToJS(Txt) 
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ReturnFromJS', [Txt]);
    UpdatePage();
}

