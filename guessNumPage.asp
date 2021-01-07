<!DOCTYPE html>
<!--
	FILE: guessNumPage.asp
	PROJECT: Client and Server Side Hi-Lo Game
	PROGRAMMER: Jessica Sim	
	FIRST VERSION: 2020-10-22
	DESCRIPTION: This script is the third page of this project and it gets input of guessed number
				In Javascript function, it validates the input if it's not blank and it's a number.
                Validating if the input is integer, and in range in server side. If the input is invalid
                displays the right error message for each cases in server side as well.
                If the input matches with the random number, it transfers to the next page called,
                winPage.asp which is server side page.
-->
<html>
<head>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia">
<link rel="STYLESHEET" type="text/css" href="cssStyleSheet.css"/>
<script type = "text/javascript">
/*
    FUNCTION: validateGuessNum
    DESCRIPTION:
        This function validates a input of guessed number by user if 
        the input is not blank and if it's number
    PARAMETERS: 
        no parameters
    RETURNS:
        no return values
*/
function validateGuessNum()
{
	var guessNum = document.getElementById('guessNumInput').value;
	var shouldSubmit = false;

	document.getElementById('guessNumError').innerHTML= "";

		if((guessNum.trim()).length == 0)
		{
			document.getElementById('guessNumInput').value = "";
			document.getElementById('guessNumError').innerHTML = "Your guessing number cannot be <b>BLANK</b>.";
		}
		else 
		{
			if(isNaN(parseInt(guessNum)))
			{
				document.getElementById('guessNumInput').value = "";
				document.getElementById('guessNumError').innerHTML = "The input must be <b>NUMBER</b>";
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
        dim minNum
        dim maxNum
        dim randNum
        dim guessNum
        dim guessNumErr
        dim guessNumRange

        'Session.Contents.RemoveAll()

        guessNum = Request.Form("guessNumInput")

        minNum = Request.Form("minNum")
        if(minNum <>"") then
            Session("minNum") = minNum
        else
            minNum = Session("minNum")
        End if

        name = Request.Form("nameInput")
        if(name <> "") then 	
			Session("name") = name
		else
			name = Session("name")
        End If	
        
        maxNum = Session("maxNum")
        if(maxNum <> "") then 		
			Session("maxNum") = maxNum
		else
            maxNum = Session("maxNum")
        End If	

        randNum = Session("randNum")

        if (guessNum <> "") then 		                        'check if guessNum is not blank
            if InStr(guessNum, ".") = 0 then                    'if guessNum is not blank, it checks if the number is not decimal
                if (CInt(guessNum) >= CInt(minNum)) and (CInt(guessNum) <= CInt(maxNum)) then     'if the number is not decimal, it checks if guessNum is greater or equal to minNum
                                                                                                  'and if guessNum is smaller or equal to maxNum
                    if (CInt(guessNum) <> CInt(randNum)) then           'if guessNum is not out of range, it checks if guessNum is equal to randNum(answer).
                                                                        'if they are eqal it goes to else clause
                        if(CInt(guessNum) = CInt(maxNum)) then          'if guessNum and randNum are different, it checks if guessNum and maxNum is equal
                            Session("maxNum") = CInt(maxNum) - 1        'if guessNum and maxNum are equal, subtract 1 from maxNum and store it back to Session variable
                        elseif(CInt(guessNum) = CInt(minNum)) then      'if guessNum and randNum are different, it checks if guessNum and minNum is equal
                            Session("minNum") = CInt(minNum) + 1        'if guessNum and minNum are equal, subtract 1 from minNum and store it back to Session variable
                        elseif(CInt(guessNum) > CInt(randNum)) then     'if guessNum and randNum are different, it checks if guessNum is greater than randNum
                            Session("maxNum") = CInt(guessNum) -1       'if guessNum is greater than randNum, subtract 1 from guessNum and store it to Session variable of maxNum
                        else                                            'if guessNum and randNum are different, it checks if guessNum is smaller than randNum
                            Session("minNum") = CInt(guessNum) + 1      'if guessNum is greater than randNum, subtract 1 from guessNum and store it to Session variable of minNum
                        end if
                    else
                        Response.Redirect ("winPage.asp")               'if guessNum and randNum are equal, it redirects to next page, "winPage.asp"
                    end if
                else  
                    guessNumErr = "Your guessing number is <b>OUTSIDE OF RANGE!</b>"        'if guessNum is out of range, it displays the error message
                end if
            else 
                guessNumErr = "Your guessing number should be <b>INTEGER</b>!"              'if guessNum is decimal, it displays error message
            end if
        end if

        guessNumRange = "Between "&Session("minNum")& " and " &Session("maxNum")        'it updates the range of guessing number every time

    %>
    <!--
        Form name: SampleForm
        Action: guessNumPage.asp
        Method: POST
        DESCRIPTION: This is a <form> layout for the page of getting guess number from user until they guess right number.
                    There are text asking "Please enter a new guess number!" with the user name which the program
                    got from first html page, hiloStart.html. And there is a input field which user can put 
                    the guess number and button to submit this form. When the user click the button to submit,
                    this form will be submitted to this current page, "guessNumpage.asp". This will lead to the javascript
                    function which will validate the input if it is number and not blank.
	-->
    <form name="SampleForm" action="guessNumPage.asp" method="POST" onsubmit="return validateGuessNum()";>
        <blockquote class="oval-thought-border" id="showGuessNumRange">
            <p><%=guessNumRange%></p>
        </blockquote>>
        <div class="borderThirdPage" style="background-color:lightblue;">
            <div id= "guessNumPrompt">
                <br/>
                <br/>
                <p style="text-align: center"><%=name%>! Please enter a guess number! </p>
                <br/>
                <div style="text-align: center"><input id= "guessNumInput" name="guessNumInput" type="text" style="text-align: center; size:30; height: 20px;" autofocus/></div>
                <br/>
                <br/>
                <div id= "guessNumError" style="color:red; text-align: center;"> <%=guessNumErr%> </div>
                <br/>
                <Input type="submit" class="goForItBtn3" id="goForIt" value="Make this Guess"/>
        </div>
	</form>
    
</body>
</html>