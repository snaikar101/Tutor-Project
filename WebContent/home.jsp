<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@include file="topNavigation.jsp" %>

<!DOCTYPE>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!--<link rel="icon" href="../../favicon.ico">-->

    <title>Home</title>

    <!-- Bootstrap core CSS -->
    <link href="styles/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->    
    <link href="styles/carousel.css" rel="stylesheet">

	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">

    google.load("feeds", "1");

    function OnLoad() {
    	  // Query for education feeds on cnn.com
    	  var query = 'site:cnn.com education ';
    	  google.feeds.findFeeds(query, findDone);
    	}

    	function findDone(result) {
    	  // Make sure we didn't get an error.
    	  if (!result.error) {
    	    // Get content div
    	    var content = document.getElementById('carousel-inner');
    	    var carouselIndex = document.getElementById('carousel-indicators');
    	    	
    	    var html = '';
    	    var indexHtml = '';

    	    // Loop through the results and print out the title of the feed and link to
    	    // the url.    	   
    	    for (var i = 0; i < result.entries.length; i++) {
    	      var entry = result.entries[i];
    	      
    	      if (i == 0)
    	      {
    	    	  indexHtml += ' <li data-target="#myCarousel" data-slide-to="'+ i +'" class="active"></li>';
    	    	html += '<div class="item active"> '
    	      }
    	      else
    	      {
    	    	  indexHtml += ' <li data-target="#myCarousel" data-slide-to="'+ i +'"></li>';
	    	      html += '<div class="item "> '
    	      }
    	      html += '<img src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="First slide"> '
	              		+ '<div class="container"> '
	               + ' <div class="carousel-caption">'
	               + ' <h1>' + entry.title + '</h1>'
	               + ' <p>' + entry.contentSnippet + '</p>'
	            	   + ' <p><a target="_blank" class="btn btn-lg btn-primary" href="' + entry.link + '" role="button">Link</a></p>'
	            	   + ' </div>'
	            	   + ' </div>'
	            	   + ' </div>';    	      
    	    }
    	    content.innerHTML = html;
    	    carouselIndex.innerHTML = indexHtml;
    	  }
    	}

    	google.setOnLoadCallback(OnLoad);

    </script>
	
  </head>
  
  <body>
  
      
    <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators" id="carousel-indicators">
        
      </ol>
      <div class="carousel-inner" role="listbox" id="carousel-inner">
        
      </div>
      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true" style="opacity:0;"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true" style="opacity:0;"></span>
        <span class="sr-only">Next</span>
      </a>
    </div><!-- /.carousel -->


    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container marketing">

      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-lg-4">          
          <h2>Upcoming Schedule</h2>
          <div class="table-responsive">
            <table class="table table-striped" id="upcoming-table">
              <thead>
                <tr>
                  <th>Skill</th>
                  <th>Description</th>
                  <th>Date & Time</th>
                </tr>
              </thead>
              <tbody>                
          </tbody>
          </table>
          </div> 
          <p><a class="btn btn-default" onclick="loadDashboard();" role="button">View Dashboard &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">          
          <h2>Recent Tutoring Sessions</h2>
          <div class="table-responsive">
            <table class="table table-striped" id="prior-table">
              <thead>
                <tr>
                  <th>Skill</th>
                  <th>Description</th>
                  <th>Date & Time</th>
                </tr>
              </thead>
              <tbody>                
          </tbody>
          </table>
          </div> 
          <p><a class="btn btn-default" onclick="loadDashboard();" role="button">View Dashboard &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">          
          <h2>Schedule a Session</h2>
          <p>Get the best tutoring session from the experts in a very reasonable price at your convenience. Visit the calendar page to schedule by clicking the below link.</p>
          <p><a class="btn btn-default" onclick="loadCal();" role="button">View Calendar &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
      </div><!-- /.row -->
      
    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
    	//href="fullCalendar.jsp"
    	
    	var qs = (function (a) {
	        if (a == "") return {};
	        var b = {};
	        for (var i = 0; i < a.length; ++i) {
	            var p = a[i].split('=');
	            if (p.length != 2) continue;
	            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
	        }
	        return b;
	    })(window.location.search.substr(1).split('&'));
    	
    	if ((qs["currentUser"] != null) && (qs["currentUser"] != ""))
		{	
			$.ajax({
          	    url: "NotificationController",
          	    type: "post",
          	  	dataType: "JSON",
          	    data: { 
          	    		user_id: qs["currentUser"]
          	    	},
				success: function(result) {
					updateDashboard(result);					    										
				},
				error: function(result)
				{
					alert("error");
				}
          	});	
		}
    	
    	function loadCal()
    	{
   			window.location = "fullCalendar.jsp?currentUser=" + qs["currentUser"];
    	}
    	
    	function loadDashboard()
    	{
   			window.location = "dashboard.jsp?currentUser=" + qs["currentUser"];
    	}
    	
    	function updateDashboard(result)
    	{    		
    		if (result != null)
    		{
				$('#upcoming-table').find("tbody").html("");
				$('#prior-table').find("tbody").html("");
		    	
				var upcoming = "";
				var prior = "";
				
    			for (i = 0; i < result.userNotificationList.length; i++)
    			{
    				var dt = new Date(result.userNotificationList[i].startDate);
    				var curDt = new Date();
    				if ((result.userNotificationList[i].acceptStatus == "2")
    						&& (curDt <= dt))
    				{
	    				upcoming += "<tr>"
		                     + "<td>" + result.userNotificationList[i].skillName + "</td>"
		                     + "<td>" + result.userNotificationList[i].description + "</td>"
		                     + "<td>" + result.userNotificationList[i].startDate + " " + result.userNotificationList[i].time  + "</td>"		                     
		                     + "</tr>";
    				}
    				else if ((result.userNotificationList[i].acceptStatus == "2")
    						&& (curDt > dt))
    				{
    					prior += "<tr>"
		                     + "<td>" + result.userNotificationList[i].skillName + "</td>"
		                     + "<td>" + result.userNotificationList[i].description + "</td>"
		                     + "<td>" + result.userNotificationList[i].startDate + " " + result.userNotificationList[i].time  + "</td>"
		                     + "</tr>";
    				}
    			}
    			$('#upcoming-table').find("tbody").html(upcoming);    			
				$('#prior-table').find("tbody").html(prior);
    		}
    	}

    </script>
  </body>
</html>
