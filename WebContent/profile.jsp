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

    <title>Profile</title>

    <!-- Bootstrap core CSS -->
    <link href="styles/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->    
    <!--<link href="styles/carousel.css" rel="stylesheet">-->
	
	<script type="text/javascript">
			    	
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
          	    url: "ProfilePage",
          	    type: "post",
          	  	dataType: "JSON",
          	    data: { 
          	    		user_id: qs["currentUser"]
          	    	},
				success: function(result) {
					$("#profile-picture").attr("src", result.picture);
					$("#profile-name").text(result.name);
					if(result.avg === 0){
						$("#avg").text('Not Rated');
					}else{
						$("#avg").text(result.avg);
					}	
					$("#senti").text(result.senti);
					updatePage(result);
				},
				error: function(result)
				{
					alert("error");
				}
          	});	
		}			
		
		function updatePage(result)
		{
			$('#interests-container').html('<div class="row skill-row">' 
		            + '<div class="col-xs-3">'
		            + '<select class="form-control">'
		            + '<option>General Category</option>'
		            + '<option>Computer Science</option>'
		            + '<option>Electricals</option>'
		            + '<option>Electronics</option>'
		            + '<option>Finance</option>'
		            + '<option>Management</option>'
		            + '<option>Biotech</option>'
		            + '</select>'
		            + '</div>'
		            + '<div class="col-xs-3">'
		            + '<input type="text" placeholder="Sub-category" class="form-control tb-skill">'
		            + '</div>'
		            + '<div class="col-xs-3">'
		            + '<input type="text" placeholder="Description" class="form-control tb-desc">'
		            + '</div>'
		            + '<div class="col-xs-1">'		                
		            + '<div class="checkbox">'
		            + '<label>'
					    + '<input type="checkbox" value="teach" class="cb-teach"></input>'						
					        + 'Teach'					                  					
					         + '</label>'
					         + '</div>'
					+ '</div>'
		            + '<div class="col-xs-1">'
		            + '<button type="submit" class="btn btn-success add-new-interest" >Add</button>'
		            + '</div>'
		            + '</div>'
		            + '<br/>');
			$("#skill-table").find("tbody").html("");
			for (i = 0; i < result.userSkill.length; i++)
			{
				
				var row = "<tr>"
					+ "<td>" + result.userSkill[i].branch_name + "</td>"
	                  + "<td>" + result.userSkill[i].skill_name + "</td>"
	                  + "<td>" + result.userSkill[i].desc + "</td>";
	            if (result.userSkill[i].ready_teach)
	            {
	            	row += "<td>Yes</td>";
	            }
	            else
	            {
	            	row += "<td>No</td>";			            	
	            }			                  
	            row += "</tr>";
				$("#skill-table").find("tbody").append(row);								
				
				// To add the skills to the update section
				var updateSkill = '<div class="row">' 
		            + '<div class="col-xs-3">'
		            + '<select class="form-control" disabled>'
		            + '<option>' + result.userSkill[i].branch_name + '</option>'
		            + '</select>'
		            + '</div>'
		            + '<div class="col-xs-3">'
		            + '<input type="text" placeholder="Sub-category" class="form-control" disabled value="' + result.userSkill[i].skill_name + '">'				            
		            + '</div>'
		            + '<div class="col-xs-3">'
		            + '<input type="text" placeholder="Description" class="form-control" disabled value="' + result.userSkill[i].desc + '">'				            
		            + '</div>'
		            + '<div class="col-xs-1">'		                
		            + '<div class="checkbox">'
		            + '<label>';
		            if (result.userSkill[i].ready_teach)
		            {
		            	updateSkill += '<input type="checkbox" value="teach" checked disabled></input>';
		            }
		            else
		            {
		            	updateSkill += '<input type="checkbox" value="teach" disabled></input>';			            	
		            }	
		            updateSkill += 'Teach'					                  					
					         + '</label>'
					         + '</div>'
					+ '</div>'
		            + '<div class="col-xs-1">'
		            + '<button type="submit" class="btn btn-danger delete-interest" id="' + result.userSkill[i].id + '" >Delete</button>'
		            + '</div>'
		            + '</div>'
		            + '<br/>';
				
		    	$('#interests-container').prepend(updateSkill);				    					    					
			}
			$("#comments-table").find("tbody").html("");
			if(result.comment1 != ''){
				$("#comments-table").find("tbody").append(result.comment1+"<br/>");
			}
			if(result.comment2 != ''){
				$("#comments-table").find("tbody").append(result.comment2+"<br/>");
			}
			if(result.comment3 != ''){
				$("#comments-table").find("tbody").append(result.comment3+"<br/>");				
			}
			if(result.comment4 != ''){
				$("#comments-table").find("tbody").append(result.comment4+"<br/>");				
			}
			if(result.comment5 != ''){
				$("#comments-table").find("tbody").append(result.comment5+"<br/>");				
			}
			
			$('#tb-additional-info').html(result.addInfo);
			$('#addInfo').html(result.addInfo);
		}
	</script>
  </head>
  
  <body>
  
    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container marketing">

<div class="row" style="padding-top: 70px;">
        <div class="col-lg-2" style="margin-left:43%; margin-right:43%;">          
          <img class="img-circle" id="profile-picture"
          	src="" alt="Generic placeholder image" 
          	style="width: 140px; height: 140px;">
          <!--<p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>-->
        </div><!-- /.col-lg-4 -->        
      </div>
  <div class="row">
        <div class="col-lg-4" style="margin-left:33.3%; margin-right:33.3%;">
          <h2 style="text-align: center;" id="profile-name"></h2>
          <p style="text-align: center;">Ratings: <span id="avg" style="color:red;font-size:12;"></span>&nbsp;&nbsp;&nbsp;&nbsp;Score: <span id="senti" style="color:red;font-size:12;"></span></p>
          <!--<p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>-->
        </div><!-- /.col-lg-4 -->        
      </div>

      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-lg-6">          
          <h2>Skills/ Proficiency</h2>
          <div class="table-responsive">
            <table class="table table-striped" id="skill-table">
              <thead>
                <tr>
                  <th>Category</th>
                  <th>Skill</th>
                  <th>Description</th>
                  <th>Will Teach</th>
                </tr>
              </thead>
              <tbody>                
          </tbody>
          </table>
          </div>                   
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-5">          
          <h2>Prior Sessions</h2>
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
          <p><a class="btn btn-default" id="dashboard" onclick="loadDashboard();" role="button">View Dashboard &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        
        
        <div class="col-lg-5">          
          <h2>Latest Comments</h2>
          <div class="table-responsive">
            <table class="table table-striped" id="comments-table">              
              <tbody>                
          </tbody>
          </table>
          </div>                   
        </div>
        
        
        
        <div class="col-lg-6">  
        	<h2>Additional Info</h2>
	          <p id='addInfo'><p><!-- I am a Masters student at NYU Polytechnic School of Engineering. Specializing in algorithms and programming. Also, proficient with concepts of Cloud computing.</p> -->	          
	        </div><!-- /.col-lg-6 -->      
        </div>        
      <br/>
      <div class="row">
        <div class="col-lg-5">        
        </div>
        <div class="col-lg-1" style="padding-left:35px;">          
          <button type="submit" class="btn btn-warning" id="update-profile">Update Profile</button>
        </div>
        <div class="col-lg-5">        
        </div>
      </div>
      <br/>
      
      
      <div class="jumbotron">
	      <div class="container">
	     	<div  id="interests-container">
		        <div class="row skill-row">
		            <div class="col-xs-3">
		                 <select class="form-control">
		                    <option>General Category</option>
		                    <option>Computer Science</option>
		                    <option>Electricals</option>
		                    <option>Electronics</option>
		                    <option>Finance</option>
		                    <option>Management</option>
		                    <option>Biotech</option>
		                </select>
		            </div>
		            <div class="col-xs-3">
		                <input type="text" placeholder="Sub-category" class="form-control tb-skill">
		            </div>
		            <div class="col-xs-3">
		                <input type="text" placeholder="Description" class="form-control tb-desc">
		            </div>
		            <div class="col-xs-1">		                
		                <div class="checkbox">
						    <label>
						        <input type="checkbox" value="teach" class="cb-teach"></input>						
						         Teach					                  					
						    </label>						
						</div>
		            </div>
		            <div class="col-xs-1">
		                <button type="submit" class="btn btn-success add-new-interest" >Add</button>
		            </div>
		        </div>
		        <br/>
		      </div>		      
		      <div class="row">
		            <div class="col-xs-11">
		                <textarea class="form-control" id ="tb-additional-info" placeholder="Additional Info"></textarea>
		            </div>
		      </div>
		      <br/>
		      <div class="row">
		            <div class="col-xs-11">		            	
		                <button type="submit" class="btn btn-primary" id="submit-profile" style="float:right;margin-left:10px;">Submit</button>
		                <button type="submit" class="btn btn-default" id="cancel-profile" style="float:right;">Cancel</button>
		            </div>
		      </div>
	      </div>	      
	    </div>      
      
      
    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>
    
    <script type="text/javascript">
    $(document).delegate(".add-new-interest", "click", function () {    
    		$('#interests-container').append('<div class="row skill-row">' 
            + '<div class="col-xs-3">'
            + '<select class="form-control">'
            + '<option>General Category</option>'
            + '<option>Computer Science</option>'
            + '<option>Electricals</option>'
            + '<option>Electronics</option>'
            + '<option>Finance</option>'
            + '<option>Management</option>'
            + '<option>Biotech</option>'
            + '</select>'
            + '</div>'
            + '<div class="col-xs-3">'
            + '<input type="text" placeholder="Sub-category" class="form-control tb-skill">'
            + '</div>'
            + '<div class="col-xs-3">'
            + '<input type="text" placeholder="Description" class="form-control tb-desc">'
            + '</div>'
            + '<div class="col-xs-1">'		                
            + '<div class="checkbox">'
            + '<label>'
			    + '<input type="checkbox" value="teach" class="cb-teach"></input>'						
			        + 'Teach'					                  					
			         + '</label>'
			         + '</div>'
			+ '</div>'
            + '<div class="col-xs-1">'
            + '<button type="submit" class="btn btn-success add-new-interest" >Add</button>'
            + '</div>'
            + '</div>'
            + '<br/>');
    	});
    
		if ((qs["c"] != null) && (qs["c"] == "t")){
			$("#update-profile").show();
			$('.jumbotron').hide();
		}
		else
		{
			$("#update-profile").hide();
			$('.jumbotron').hide();
			$('#dashboard').hide();
		}
		
		$(document).delegate("#update-profile", "click", function () {
			// fetch all the data from db
    		$('.jumbotron').show();
    		$("#update-profile").hide();
    	});	
		
		$(document).delegate("#submit-profile", "click", function () {
			// insert all the data to db
			var skillList = [];
			var addInfo = $("#tb-additional-info").val();			
			
			$(".skill-row").each(function (index) {
				if ($(this).find(".tb-skill").prop("value") != null &&
						$(this).find(".tb-skill").prop("value").trim() != "")
				{
					skillList.push($(this).find("select").prop("value") + "|" + 
							  $(this).find(".tb-skill").prop("value") + "|" + 
							  $(this).find(".tb-desc").prop("value") + "|" + 
							  $(this).find(".cb-teach").prop("checked"));
				}
			  });
			
			$.ajax({
          	    url: "UserSkill",
          	    type: "post",
          	  	dataType: "JSON",
          	    data: { 
          	    		user_id: qs["currentUser"],
          	    		skill_list: skillList,
          	    		addInfo:addInfo,
          	    		action: "add"
          	    	},
				success: function(result) {
					updatePage(result);					    										
				},
				error: function(result)
				{
					alert("error");
				}
          	});	
    		$('.jumbotron').hide();
    		$("#update-profile").show();
    	});	
		
		$(document).delegate("#cancel-profile", "click", function () {
			// insert all the data to db
    		$('.jumbotron').hide();
    		$("#update-profile").show();
    	});
		
		$(document).delegate(".delete-interest", "click", function () {
			
			var skillToDelete = $(this).prop("id");
			if (skillToDelete != null && skillToDelete != "")
			{
				$.ajax({
	          	    url: "UserSkill",
	          	    type: "post",
	          	  	dataType: "JSON",
	          	    data: { 
	          	    		user_id: qs["currentUser"],
	          	    		id: skillToDelete,
	          	    		action: "delete"
	          	    	},
					success: function(result) {
							updatePage(result);    					    										
					},
					error: function(result)
					{
						alert("error");
					}
	          	});
			}
			// insert all the data to db
    		//$('.jumbotron').hide();
    		//$("#update-profile").show();
    	});
		
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
		
		function updateDashboard(result)
    	{    		
    		if (result != null)
    		{				
				$('#prior-table').find("tbody").html("");
		    					
				var prior = "";
				
    			for (i = 0; i < result.userNotificationList.length; i++)
    			{
    				var dt = new Date(result.userNotificationList[i].startDate);
    				var curDt = new Date();
    				if ((result.userNotificationList[i].acceptStatus == "2")
    						&& (curDt > dt))
    				{
    					prior += "<tr>"
		                     + "<td>" + result.userNotificationList[i].skillName + "</td>"
		                     + "<td>" + result.userNotificationList[i].description + "</td>"
		                     + "<td>" + result.userNotificationList[i].startDate + " " + result.userNotificationList[i].time  + "</td>"
		                     + "</tr>";
    				}
    			}    		
				$('#prior-table').find("tbody").html(prior);
    		}
    	}

	
		function loadDashboard()
    	{			
   			window.location = "dashboard.jsp?currentUser=" + qs["currentUser"];
    	}
    </script>
  </body>
</html>
