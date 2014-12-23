<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

    <title>Dashboard</title>

    <!-- Bootstrap core CSS -->
    <link href="styles/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="styles/dashboard.css" rel="stylesheet">

    <!-- <script src="../../assets/js/ie-emulation-modes-warning.js"></script> -->
  
    <script type="text/javascript">

    $(document).ready(function(){
    	//$('#upcoming-table').hide();
    	$('#prior-table').hide();
    	$('#pending-table').hide();
    	    	
    	$(document).delegate(".schedule-tabs", "click", function (){    	
    		    		
    		$('#upcoming-table').hide();
        	$('#prior-table').hide();
        	$('#pending-table').hide();
        	var tab = $(this).find('a').prop("text");

        	 $('.schedule-tabs').removeClass("active");             
           	 $(this).addClass("active");
        	
        	if (tab == "Upcoming Schedules")
        	{
        		$('#upcoming-table').show();		
        	}
        	else if (tab == "Prior Schedules")
        	{
            	$('#prior-table').show();	
        	}
        	else 
        	{
            	$('#pending-table').show();
        	}
    	});
    });
    
    </script>
    <style type="text/css">
    	.pricePerHr{
    		max-width: 70px;
			float: right !important;
    	}
    </style>
  </head>

  <body>

    <div class="container-fluid">
      <div class="row">
        <!-- <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li>
            <li><a href="#">Reports</a></li>
            <li><a href="#">Analytics</a></li>
            <li><a href="#">Export</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item</a></li>
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
            <li><a href="">More navigation</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
          </ul>
        </div>-->
        <div class="col-md-12 main" style="align:center;">
          <h1 class="page-header">Dashboard Schedules</h1>

          <!-- <div class="row placeholders">
            
            <div class="col-xs-6 col-sm-3 placeholder">
              <img data-src="holder.js/200x200/auto/vine" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Ratings</h4>
              <span id='rating' class="text-muted"></span>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <img data-src="holder.js/200x200/auto/sky" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>Score</h4>
              <span id='senti' class="text-muted"></span>
            </div>
           
          </div> -->
          
		  <ul class="nav nav-tabs" role="tablist">
	        <li role="presentation" class="schedule-tabs active" ><a href="#">Upcoming Schedules</a></li>
	        <li role="presentation" class="schedule-tabs" ><a href="#">Prior Schedules</a></li>
	        <li role="presentation" class="schedule-tabs" ><a href="#">Pending</a></li>
	      </ul>
          <div class="table-responsive">
            <table class="table table-striped" id="upcoming-table">
              <thead>
                <tr>
                  <th>Tutor</th>
                  <th>Student</th>
                  <th>Category</th>
                  <th>Skill</th>
                  <th>Description</th>
                  <th>Date & Time</th>
                  <th>Location</th>
                </tr>
              </thead>
              <tbody>
                
              </tbody>
            </table>

<table class="table table-striped" id="prior-table">
              <thead>
                <tr>
                  <th>Tutor</th>
                  <th>Student</th>
                  <th>Category</th>
                  <th>Skill</th>
                  <th>Description</th>
                  <th>Date & Time</th>                  
                  <th>Ratings & Comments</th>
                </tr>
              </thead>
              <tbody>
                
              </tbody>
            </table>

<table class="table table-striped" id="pending-table">
              <thead>
                <tr>
                  <th>Tutor</th>
                  <th>Student</th>
                  <th>Category</th>
                  <th>Skill</th>
                  <th>Description</th>
                  <th>Date & Time</th>
                  <th>Location</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
 			
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>
    <!-- <script src="../../assets/js/docs.min.js"></script>-->
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		
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
    			qs["currentUser"] = qs["currentUser"].replace("#","");
    			
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
    		
    		$(document).delegate(".btn-accept", "click", function (){
    			var id = $(this).prop("id");
    			var price = "0";
    			if ($("#btn-" + id).val() != "")
    			{
    				price = $("#btn-" + id).val();
    			}
    			$.ajax({
	          	    url: "NotificationAction",
	          	    type: "post",	          	  	
	          	    data: { 
	          	    		user_id: qs["currentUser"],
	          	    		n_id: id,
	          	    		price: price,
	          	    		action: "accept"
	          	    	},
					success: function(result) {
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
						//$(this).attr("disabled",true);			    										
					},
					error: function(result)
					{
						alert("error");
					}
	          	});	    			    		
    		});
    		
    		$(document).delegate(".btn-accept2", "click", function (){
    			var id = $(this).prop("id");
    			var price = "0";
    			if ($("#btn-" + id).val() != "")
    			{
    				price = $("#btn-" + id).val();
    			}
    			$.ajax({
	          	    url: "NotificationAction",
	          	    type: "post",	          	  	
	          	    data: { 
	          	    		user_id: qs["currentUser"],
	          	    		n_id: id,
	          	    		price: price,
	          	    		action: "accept2"
	          	    	},
					success: function(result) {
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
						//$(this).attr("disabled",true);			    										
					},
					error: function(result)
					{
						alert("error");
					}
	          	});	    			    		
    		});
    		
    		$(document).delegate(".btn-rate", "click", function (){
    			var id = $(this).prop("id");
    			var rate = $("#rate-" + id).val();
    			var comment="";
    			if ($("#com-" + id).val() != "")
    			{
    				comment = $("#com-" + id).val();
    			}
    			$.ajax({
	          	    url: "NotificationAction",
	          	    type: "post",	          	  	
	          	    data: { 
	          	    		user_id: qs["currentUser"],
	          	    		n_id: id,
	          	    		rate: rate,
	          	    		comment:comment,
	          	    		action: "comment"
	          	    	},
					success: function(result) {
						alert("Your comment posted successfully!");
						//$(this).attr("disabled",true);			    										
					},
					error: function(result)
					{
						//alert("error");
					}
	          	});
    		});
    		
    		function updateDashboard(result)
        	{    		
        		// 0 - first time
        		// 1 - tutor accept
        		// 3 - all accept
        		if (result != null)
        		{
    				$('#upcoming-table').find("tbody").html("");
    				$('#prior-table').find("tbody").html("");
    		    	$('#pending-table').find("tbody").html("");
    		    	
    				var upcoming = "";
    				var prior = "";
    				var pending = "";
    				
        			for (i = 0; i < result.userNotificationList.length; i++)
        			{
        				var dt = new Date(result.userNotificationList[i].startDate);
        				var curDt = new Date();
        				if ((result.userNotificationList[i].acceptStatus == "2")
        						&& (curDt <= dt))
        				{
    	    				upcoming += "<tr>"
    		                     + "<td><a href='profile.jsp?currentUser=" + result.userNotificationList[i].tutorId  + "'>" + result.userNotificationList[i].tutorName + "</a></td>"
    		                     + "<td><a href='profile.jsp?currentUser=" + result.userNotificationList[i].studentId  + "'>" + result.userNotificationList[i].requestedUserName + "</a></td>"
    		                     + "<td>" + result.userNotificationList[i].category + "</td>"
    		                     + "<td>" + result.userNotificationList[i].skillName + "</td>"
    		                     + "<td>" + result.userNotificationList[i].description + "</td>"
    		                     + "<td>" + result.userNotificationList[i].startDate + " " + result.userNotificationList[i].time  + "</td>"
    		                     + "<td>" + result.userNotificationList[i].location + "</td>"
    		                     + "</tr>";
        				}
        				else if ((result.userNotificationList[i].acceptStatus == "2")
        						&& (curDt > dt))
        				{
        					prior += "<tr>"
        						 + "<td><a href='profile.jsp?currentUser=" + result.userNotificationList[i].tutorId  + "'>" + result.userNotificationList[i].tutorName + "</a></td>"
   		                     	 + "<td><a href='profile.jsp?currentUser=" + result.userNotificationList[i].studentId  + "'>" + result.userNotificationList[i].requestedUserName + "</a></td>"
    		                     + "<td>" + result.userNotificationList[i].category + "</td>"
    		                     + "<td>" + result.userNotificationList[i].skillName + "</td>"
    		                     + "<td>" + result.userNotificationList[i].description + "</td>"
    		                     + "<td>" + result.userNotificationList[i].startDate + " " + result.userNotificationList[i].time  + "</td>"    		                     
    		                     + "<td><div class='input-group' >";
    		                     if (qs["currentUser"] == result.userNotificationList[i].studentId){
			                     prior += "<span style='padding-right:20px;'><input type='text' id='com-" + result.userNotificationList[i].notificationId + "' placeholder='comment'></span>" /*  class='form-control pricePerHr' */
			                    	     + "<select id='rate-" + result.userNotificationList[i].notificationId + "'><option>5</option><option>4</option><option>3</option><option>2</option><option>1</option></select>"
					                     + "<span class='input-group-btn'>"
					                     + "<button class='btn btn-success btn-warning btn-rate' type='button' id='" + result.userNotificationList[i].notificationId + "'>Rate</button>"
					                     + "</span>"
					                     + "</div></tr>";
    		                     }
    		                     else{
    		                    	 prior += "</div></tr>";
    		                     }
			                     
        				}
        				if ((result.userNotificationList[i].acceptStatus == "0")
        						|| (result.userNotificationList[i].acceptStatus == "1"))
        				{
        					pending += "<tr>"
        						 + "<td><a href='profile.jsp?currentUser=" + result.userNotificationList[i].tutorId  + "'>" + result.userNotificationList[i].tutorName + "</a></td>"
   		                     	 + "<td><a href='profile.jsp?currentUser=" + result.userNotificationList[i].studentId  + "'>" + result.userNotificationList[i].requestedUserName + "</a></td>"
    		                     + "<td>" + result.userNotificationList[i].category + "</td>"
    		                     + "<td>" + result.userNotificationList[i].skillName + "</td>"
    		                     + "<td>" + result.userNotificationList[i].description + "</td>"
    		                     + "<td>" + result.userNotificationList[i].startDate + " " + result.userNotificationList[i].time  + "</td>"
    		                     + "<td>" + result.userNotificationList[i].location + "</td>"
    		                     //+ "<td><button type='submit' class='btn btn-success btn-accept' id='" + result.userNotificationList[i].notificationId + "' >Accept</button></td>"
    		                     + "<td><div class='input-group' >";		                     
    		                     
    		                    if (result.userNotificationList[i].acceptStatus == "0")
    		                    {
    			                     if (qs["currentUser"] == result.userNotificationList[i].studentId)
    			                     {
    			                 		pending += "";   	 
    			                     }
    			                     else if (qs["currentUser"] != result.userNotificationList[i].studentId)
    			                     {
    			                    	 pending += "<input type='text' id='btn-" + result.userNotificationList[i].notificationId + "' placeholder='price' class='form-control pricePerHr'>"
    					                     + "<span class='input-group-btn'>"
    					                     + "<button class='btn btn-success btn-warning btn-accept' type='button' id='" + result.userNotificationList[i].notificationId + "'>Accept</button>"
    					                     + "</span>";
    			                     }
    		                    }
    		                    if (result.userNotificationList[i].acceptStatus == "1")
    		                    {
    			                     if (qs["currentUser"] == result.userNotificationList[i].studentId)
    			                     {
    			                    	 pending += "<input type='text' id='btn-" + result.userNotificationList[i].notificationId + "' placeholder='price' value='" 
    			                    	 	 + result.userNotificationList[i].price + "' disabled class='form-control pricePerHr'>"
    					                     + "<span class='input-group-btn'>"
    					                     + "<button class='btn btn-success btn-accept2' type='button' id='" + result.userNotificationList[i].notificationId + "'>Accept</button>"
    					                     + "</span>";   	 
    			                     }
    			                     else if (qs["currentUser"] != result.userNotificationList[i].studentId)
    			                     {
    			                    	 pending += "<input type='text' id='btn-" + result.userNotificationList[i].notificationId + "' placeholder='price' value='" 
    			                    	 	 + result.userNotificationList[i].price + "' disabled class='form-control pricePerHr'>"
    					                     + "<span class='input-group-btn'>"
    					                     + "<button class='btn btn-default btn-rate' disabled type='button' id='" + result.userNotificationList[i].notificationId + "'>Pending</button>"
    					                     + "</span>";
    			                     }
    		                    }
    		                    pending += "</div></tr>"
    			                     + "</tr>";
        				}
        			}
        			$('#upcoming-table').find("tbody").html(upcoming);    			
    				$('#prior-table').find("tbody").html(prior);
    		    	$('#pending-table').find("tbody").html(pending);
        		}
        	}

    	});
    	
    	    	
    </script>
  </body>
</html>
