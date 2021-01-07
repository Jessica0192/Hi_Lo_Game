<!DOCTYPE html>
<!--
	FILE: getMaxNumPage.asp
	PROJECT: Client and Server Side Hi-Lo Game
	PROGRAMMER: Jessica Sim	
	FIRST VERSION: 2020-10-22
	DESCRIPTION: This script is the second page of this project and it gets input of maximum guess number.
				In Javascript function, it validates the input if it's not blank and it's a number.
				Validating if the input is greater than 1, and it's a integer value in server side. 
				If the input meets all the validation, it generates the random integer in range in server side and
				it transfers the page to next page called, guessNumPage.asp which is server page.
-->
<html>
<head>
<title> getMaxNumPage.html </title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia">
<link rel="STYLESHEET" type="text/css" href="cssStyleSheet.css"/>
<script type = "text/javascript">
/*
	FUNCTION: validateMaxNum
	DESCRIPTION:
		This function validates a input of maximum number if
		it's not blank and it's a number
	PARAMETERS: 
		no parameters
	RETURNS:
		no return values
*/
function validateMaxNum()
{
	var maxNum = document.getElementById('maxNumInput').value;
	var shouldSubmit = false;

	document.getElementById('maxNumError').innerHTML= "";

		if((maxNum.trim()).length == 0)
		{
			document.getElementById('maxNumInput').value = "";
			document.getElementById('maxNumError').innerHTML = "Your maximum number cannot be <b>BLANK</b>";
		}
		else 
		{
			if(isNaN(parseInt(maxNum)))
			{
				document.getElementById('maxNumInput').value = "";
				document.getElementById('maxNumError').innerHTML = "The input must be <b>NUMBER</b>";
			}
			else
			{
				shouldSubmit= true;
			}
		}
		
		return shouldSubmit;
}
</script>
</head>
<body>
	<h1 style="text-align: center;">Let's start guessing the number!</h1>
	<%
		dim name
		dim maxNum
		dim err 
		dim randNum
		dim minNum

		minNum = 1
		Session("minNum") = 1

		name = Request.Form("nameInput")
		if(name <> "") then 		' the form with "name" has just been submitted - so turn it into a Session variable
			Session("name") = name
		else
			name = Session("name")
		End If	

		maxNum = Request.Form("maxNumInput")
		if(maxNum <> "") then 		' the form with "name" has just been submitted - so turn it into a Session variable
			Session("maxNum") = maxNum
		End If	

		if (maxNum <> "") then 						'check if maxNum is not blank
			if InStr(maxNum, ".") = 0 then			'check if maxNum is not a decimal number
				if CInt(maxNum) > 1 then			'check if maxNum is greater than 1
					Randomize()						'generate random number
					randNum = Int((maxNum)*Rnd+minNum)		'calculate the random number between minNum and maxNum then store it into randNum
					Session("randNum") = randNum			'store the randNum into Session variable of randNum
					Response.Redirect("guessNumPage.asp")	'it redirects to the next page, "guessNumPage.asp"
				else  
					err = "Your maximum number should be <b>GREATER</b> than 1!"		'if maxNum is greater than 1, it displays the error message
				end if
			else 
				err = "Your maximum number should be <b>INTEGER</b>!"			'if maxNum is decimal, it displays the error message
			end if
		end if
	%>
	<!--
		Form name: SampleForm
		Action: getMaxNumPage.asp
		Method: POST
		DESCRIPTION: This is a <form> layout for the page of getting maximum guess number from user.
					There are text asking "Please enter your maximum guess number!" with the user name which the program
					got from last html page, hiloStart.html. And there is a input field which user can put 
					the maximum guess number and button to submit this form. When the user click the button to submit,
					this form will be submitted to this current page, "getMaxNumPage.asp". This will lead to the javascript
					function which will validate the input if it is number and not blank.
	-->
	<form name="SampleForm" action="getMaxNumPage.asp" method="POST" onsubmit="return validateMaxNum()";>
		<br/>
        <br/>
	    <div class="borderSecondPage" style="background-color:lightblue">
        <div id= "maxNumPrompt">
			<br/>
            <br/>
			<p style="text-align: center">Hello, <%=name%>! Please enter your maximum guess number!</p>
			<br/>
			<div style="text-align: center"><input id= "maxNumInput" name="maxNumInput" type="text" style="text-align: center; size:30; height: 20px;" autofocus/></div>
			<br/>
			<br/>
			<div id= "maxNumError" style="color:red; text-align: center;"> <%=err%> </div>
			<Input type="submit" class="goForItBtn2" id="goForIt" value="Enter"/>
		</div>
		</div>
	</form>
</body>
</html>