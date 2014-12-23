<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    
    <meta name="google-signin-clientid" content="161720130918-gduhh2bt38eph8hg4igfksuomj5v2pcn.apps.googleusercontent.com" />
<meta name="google-signin-scope" content="https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email" />
<meta name="google-signin-requestvisibleactions" content="http://schema.org/AddAction" />
<meta name="google-signin-cookiepolicy" content="single_host_origin" />
    
    
    <title>Tutor</title>

    <!-- Bootstrap core CSS -->
    <link href="styles/bootstrap.css" rel="stylesheet">
        
        
        <script type="text/javascript">
        var currentUser = "";
      //This is called with the results from from FB.getLoginStatus().
        function statusChangeCallback(response) {
          console.log('statusChangeCallback');
          console.log(response);
          if (response.status === 'connected') {    	
            // Logged into your app and Facebook.
            FB.api('/me', {fields: 'email'}, function(response) {            	
            	currentUser = response.email;            	
            	
            	$("#profile-id").attr("href", "profile.jsp?currentUser=" + response.email + "&c=t");
            	$("#home-id").attr("href", "home.jsp?currentUser=" + response.email);
            	$("#dashboard-id").attr("href", "dashboard.jsp?currentUser=" + response.email);            
            	$("#fulCal-id").attr("href", "fullCalendar.jsp?currentUser=" + response.email);            	 	            
            	
            });
          } else if (response.status === 'not_authorized') {
           // window.location = "/Tutor";
           	checkGoogle();
          } else {
          //	window.location = "/Tutor";
          	checkGoogle();
          }
        }

        // This function is called when someone finishes with the Login
        // Button.  See the onlogin handler attached to it in the sample
        // code below.
        function checkLoginState() {
          FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
          });
        }

        window.fbAsyncInit = function() {
        FB.init({
          appId      : '618636918261763',
          cookie     : true,  // enable cookies to allow the server to access 
                              // the session
          xfbml      : true,  // parse social plugins on this page
          version    : 'v2.1' // use version 2.1
        });

        FB.getLoginStatus(function(response) {
          statusChangeCallback(response);
        });

        };

        // Load the SDK asynchronously
        (function(d, s, id) {
          var js, fjs = d.getElementsByTagName(s)[0];
          if (d.getElementById(id)) return;
          js = d.createElement(s); js.id = id;
          js.src = "//connect.facebook.net/en_US/sdk.js";
          fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));

        
        
        function checkGoogle()
        {
      	  gapi.auth.checkSessionState({session_state: null}, function(isUserNotLoggedIn){
		    if (isUserNotLoggedIn) {
		    	if ((window.location.href.split("Tutor/")[1] != "") 
	            		  || (window.location.href.split("Tutor/")[1] != "index.jsp"))
	              {
	      		  	window.location = "/Tutor";
	              }
				else {   
	      		   // console.log('Sign-in state: ' + authResult['error']);	      	   		
	      	  	}		    		    
		    }
		    else
		    {
		    	gapi.client.load('oauth2', 'v2', function() {
        	    	gapi.client.oauth2.userinfo.get().execute(function(resp) {        	
						currentUser = resp.email;						
        	    	});
      	   		});	
		    }
      	  });
        }
        function logout(){
               
        }

        </script>
  </head>

  <body onload="checkLoginState();">
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Tutor</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav" style="width:90%;">            
            <li class="active"><a href="home.jsp" id="home-id" class="li-nav">Home</a></li>
            <li class=""><a class="li-nav" id="dashboard-id" href="dashboard.jsp">Dashboard</a></li>
            <!-- <li class=""><a class="li-nav" href="#about">About</a></li>
            <li class=""><a class="li-nav" href="#contact">Contact</a></li> -->
            <li class=""><a class="li-nav" id="profile-id" href="profile.jsp">Profile</a></li>
            <li class=""><a class="li-nav" id="fulCal-id" href="fullCalendar.jsp">Schedule Session</a></li>
            <li style="float:right;"><a class="li-nav" onclick="logout()" href="/">Logout</a></li>            
          </ul>
          <!--<form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>-->
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>        
    <script src="scripts/bootstrap.min.js"></script>
    <script src="https://apis.google.com/js/client:platform.js" async defer></script>
    <script>
  
  // To change the active status of the tab bars   
  $(".li-nav").each(function (index) {
	  $(this).parent("li").removeClass("active");
      if (window.location.href.contains($(this).attr("href").split('.')[0]))
      {
    	  $(this).parent("li").addClass("active");
    	  if ($(this).prop("innerHTML") == "Logout")
    	  {
    		  $(this).parent("li").removeClass("active");  
    	  }
    	  //alert($(this).attr("href").split('.')[0]);
      }
      if ((window.location.href.split("Tutor/")[1] == "") 
    		  || (window.location.href.split("Tutor/")[1] == "index.jsp"))
      {
    	  $(this).parent("li").hide();
      }
      else
      {
    	  $(this).parent("li").show();
      }
  });
   
</script>
  </body>
</html>
