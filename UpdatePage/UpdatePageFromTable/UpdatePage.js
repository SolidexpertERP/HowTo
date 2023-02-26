"use strict"

function ShowPopUp()
{ 
  alert("I am an alert box!");
}

function AddPhoto()
{     
  var controlAddIn = document.getElementById('controlAddIn');   
  controlAddIn.insertAdjacentHTML('beforeend', '<img style ="display: block; margin-left: auto; margin-right: auto; width: 50%"; src="' +
    Microsoft.Dynamics.NAV.GetImageResource('UpdatePage/UpdatePageFromTable/car2.jpg') +
    '">');
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

