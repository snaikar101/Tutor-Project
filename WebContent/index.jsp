
<%@include file="topNavigation.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
        
    <!-- <link rel="icon" href="../../favicon.ico">-->

    <title>Tutor</title>

    <!-- Bootstrap core CSS -->
    <link href="styles/bootstrap.css" rel="stylesheet">
    <link href="styles/login.css" rel="stylesheet">

    <!-- <script src="../../assets/js/ie-emulation-modes-warning.js"></script>-->

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <script type="text/javascript">
    	function fbLogin()
    	{
    		 FB.login(
   			        function(response) {
   			        	checkLoginState(); 
   			        }, 
   			    	{
   			        	scope:'public_profile,email,user_friends,'
   			        }
   			    );     
    	}
    </script>
  </head>

  <body>	
  
    <div class="container">

      <div class="starter-template">
        <h1>        
        	<img class="login-btn" src="images/facebook.png" onclick="fbLogin();"/> 
        	<img class="login-btn" src="images/googlePlus.png" id="signinButton" />
        </h1>
        <p class="lead">To use the best online Tutor finder services</p>
      </div>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
    	
    // This is called with the results from from FB.getLoginStatus().
    function statusChangeCallback(response) {
      console.log('statusChangeCallback');
      console.log(response);
      // The response object is returned with a status field that lets the
      // app know the current login status of the person.
      // Full docs on the response object can be found in the documentation
      // for FB.getLoginStatus().
      if (response.status === 'connected') {    	
        // Logged into your app and Facebook.       
            	
        testAPI();
      } else if (response.status === 'not_authorized') {
        // The person is logged into Facebook, but not your app.
        document.getElementById('status').innerHTML = 'Please log ' +
          'into this app.';
      } else {
        // The person is not logged into Facebook, so we're not sure if
        // they are logged into this app or not.
        document.getElementById('status').innerHTML = 'Please log ' +
          'into Facebook.';
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

    // Now that we've initialized the JavaScript SDK, we call 
    // FB.getLoginStatus().  This function gets the state of the
    // person visiting this page and can return one of three states to
    // the callback you provide.  They can be:
    //
    // 1. Logged into your app ('connected')
    // 2. Logged into Facebook, but not your app ('not_authorized')
    // 3. Not logged into Facebook and can't tell if they are logged into
    //    your app or not.
    //
    // These three cases are handled in the callback function.

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

    // Here we run a very simple test of the Graph API after login is
    // successful.  See statusChangeCallback() for when this call is made.
    function testAPI() {
      console.log('Welcome!  Fetching your information.... ');
      FB.api('/me', {fields: 'last_name, first_name, email, id, name, link, picture'}, function(response) {     
      	
        if ((window.location.href.split("Tutor/")[1] == "") 
      		  || (window.location.href.split("Tutor/")[1] == "index.jsp"))
        {
      	 
        	$.ajax({
        	    url: "TutorMain",
        	    type: "POST",
        	    data: { 
        	    		last_name: response.last_name, first_name: response.first_name, email: response.email, 
        	    		id: response.id, name: response.name, link: response.link, picture: response.picture.data.url, type: "f"
        	    	},
	        		success: function (responseText){

	        	   		$("#profile-id").attr("href", "profile.jsp?currentUser=" + response.email + "&c=t");
	        	       	$("#home-id").attr("href", "home.jsp?currentUser=" + response.email);
	        	       	$("#dashboard-id").attr("href", "dashboard.jsp?currentUser=" + response.email);
	        	       	$("#fulCal-id").attr("href", "fullCalendar.jsp?currentUser=" + response.email);
	        			window.location = "home.jsp?currentUser=" + response.email;
	        		},
        			error: function (responseText){
	        			alert("error" + responseText.responseText);
	        		}
        	    });
      	  
      	  //alert(response.last_name + " " + response.first_name + " " + response.email + " " +  
      	    //		response.id + " " + response.name + " " + response.link + " " + response.picture.data.url);      	  
        }
             
      });       
    }
    
    </script>
    
    <script src="https://apis.google.com/js/client:platform.js?onload=render" async defer></script>
    
    <script type="text/javascript">
    
    function render() {
    	   var additionalParams = {
    	     'callback': signinCallback
    	   };

    	   var signinButton = document.getElementById('signinButton');
    	   signinButton.addEventListener('click', function() {
    		   gapi.auth.signIn(additionalParams);
    	   });
    	   
    	   
    	   gapi.auth.checkSessionState({session_state: null}, function(isUserNotLoggedIn){
   		    if (isUserNotLoggedIn) {
   	    	  // gapi.auth.signIn(additionalParams);	    		    
   		    }
   		    else
   		    {
   		    	googleOAuth();	
   		    }
           });    	   
    	 }
    
    	 function signinCallback(authResult) {
    	  if (authResult['status']['signed_in']) {    
    		
    		  googleOAuth();
    	  
    	  } else {   
    	    console.log('Sign-in state: ' + authResult['error']);
    	  }
    	}    
    	 
    	function googleOAuth() {
    		gapi.client.load('oauth2', 'v2', function() {
        	    gapi.client.oauth2.userinfo.get().execute(function(resp) {
        	      // Shows user email
        	      console.log(resp.email);
        		  console.log(resp.name);
        		  console.log(resp.picture);
        		          		  
              	$.ajax({
              	    url: "TutorMain",
              	    type: "POST",
              	    data: { 
              	    		last_name: "", first_name: resp.name, email: resp.email, 
              	    		id: "", name: resp.name, link: "", picture: resp.picture, type: "g"
              	    	}
              	    });
            	  
        	    })
        	  });    	    
        	  window.location = "home.jsp";    		
    	}
    
    </script>    
  </body>
</html>
