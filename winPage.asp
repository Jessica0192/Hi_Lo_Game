<!DOCTYPE html>
<!--
	FILE: winPage.asp
	PROJECT: Client and Server Side Hi-Lo Game
	PROGRAMMER: Jessica Sim	
	FIRST VERSION: 2020-10-22
    DESCRIPTION: This script is the final page of this project and it simply displays the message, "You Win!"
                It also gives ability to user to play the game again. If the user press Play Again button, 
                it transfers to getMaxNumPage.asp to let user play the game again.
-->
<html>
<head>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia">
<link rel="STYLESHEET" type="text/css" href="cssStyleSheet.css"/>
</head>
<body style="background-color:salmon">
    <%
        Session.Contents.Remove("maxNum")       'remove Session variable of maxNum
        Session.Contents.Remove("minNum")       'remove Session variable of minNum
        Session.Contents.Remove("randNum")      'remove Session variable of randNum
    %>
    <!--
        Form name: SampleForm
        Action: guessNumPage.asp
        Method: POST
        DESCRIPTION: This is a <form> layout for the page of showing that user guessed the right number.
                    It changed the background color of the page and showed the text "You Win!! You guess the number!!".
                    If user click Play Again button this will lead to the page of getting maximum guessing number again, 
                    "getMaxNumPage.asp".
	-->
    <form name="SampleForm" action="guessNumPage.asp" method="POST">
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
            <div id= "guessSuccess">
                <p style="text-align: center; font-size: 30px;">You Win!! You guessed the number!!</p>
                <br>
                <input id= "playAgain" class="playAgainBtn" type="button" value="Play Again" onclick="window.location.href='getMaxNumPage.asp'"/>
            </div>
    </form>
</body>
</html>