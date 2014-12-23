<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="topNavigation.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link rel='stylesheet' href='styles/cupertino/jquery-ui.min.css' />
<link href='styles/fullcalendar.css' rel='stylesheet' />
<script src='scripts/moment.min.js'></script>
<script src='scripts/jquery.min.js'></script>
<script src='scripts/fullcalendar.js'></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<!-- Bootstrap core CSS -->
<link href="styles/bootstrap.css" rel="stylesheet">   
    
    
 <script type="text/javascript" src="scripts/jquery.timepicker.js"></script>
  <link rel="stylesheet" type="text/css" href="styles/jquery.timepicker.css" />

  <script type="text/javascript" src="scripts/bootstrap-datepicker.js"></script>
  <link rel="stylesheet" type="text/css" href="styles/bootstrap-datepicker.css" />
<script>

function initialize() {
	  // Create the autocomplete object, restricting the search
	  // to geographical location types.
	  autocomplete = new google.maps.places.Autocomplete(
	      /** @type {HTMLInputElement} */(document.getElementById('autocomplete')),
	      { types: ['geocode'] });
	  // When the user selects an address from the dropdown,
	  // populate the address fields in the form.
	  google.maps.event.addListener(autocomplete, 'place_changed', function() {
	    fillInAddress();
	  });
	}
	
function fillInAddress() {
	  // Get the place details from the autocomplete object.
	  var place = autocomplete.getPlace();

	  // Get each component of the address from the place details
	  // and fill the corresponding field on the form.
	  for (var i = 0; i < place.address_components.length; i++) {
	    var addressType = place.address_components[i].types[0];
	    lat = place.geometry.location.D;
	    lon = place.geometry.location.k;
	    //if (componentForm[addressType]) {
	      //var val = place.address_components[i][componentForm[addressType]];
	     // document.getElementById(addressType).value = val;
	    //}
	  }
	}
	// [END region_fillform]

	// [START region_geolocation]
	// Bias the autocomplete object to the user's geographical location,
	// as supplied by the browser's 'navigator.geolocation' object.
	function geolocate() {
	  if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(function(position) {
	      var geolocation = new google.maps.LatLng(
	          position.coords.latitude, position.coords.longitude);
	      var circle = new google.maps.Circle({
	        center: geolocation,
	        radius: position.coords.accuracy
	      });
	      autocomplete.setBounds(circle.getBounds());
	    });
	  }
	}		
	
	$(document).ready(function() {
		
		initialize();
		
		$('#calendar').fullCalendar({
			theme: true,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			
			editable: true,
			eventLimit: true, // allow "more" link when too many events
	        selectable: true,
	        selectHelper: true,
			select: function (start, end, allDay) {

	            var param1 = new Date(start);
	            var param2 = (param1.getMonth() + 1) + '/' + (param1.getDate() + 1) + '/' + param1.getFullYear();
	            var dt = new Date();
	            if (dt <= param1)
	            {	            
		            $("#schedule-date").prop("value", param2);//$(this).prop("attributes")["data-date"].nodeValue);
		            $("#myModal").modal('show');
				}
	        },
			events: [
				{
					title: 'All Day Event',
					start: '2014-09-01'
				},
				{
					title: 'Long Event',
					start: '2014-09-07',
					end: '2014-09-10'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2014-09-09T16:00:00'
				},
				{
					title: 'Click for Google',
					url: 'http://google.com/',
					start: '2014-09-28'
				}
			]
		});
		
	});	
	
	$(document).ready(function(){
		$('#timepicker1').timepicker();
		$('#timepicker2').timepicker();
		
	    $(".launch-modal").click(function(){
	        $("#myModal").modal({
	            backdrop: true
	        });
	    });
	    
	    $(".open-modal").click(function(){
	        $("#myModal").modal('show');
	        
	    });
	    
        $(".hide-modal").click(function(){
            $("#myModal").modal('hide');
        });	    
	});

</script>
<style>

	#calendar {
		max-width: 900px;
		margin: 0 auto;
		margin-top: 70px;
	}

.pac-container
{
	z-index: 9999 !important;
}
</style>
</head>
<body>    
	<div id='calendar'></div>

    <div id="myModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close hide-modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Schedule a Tutoring Sessoin</h4>
                </div>
                <div class="modal-body">
                     
					<div class="row skill-row">
			            <div class="col-xs-6">
			                 <select class="form-control select-cat">
			                    <option>General Category</option>
			                    <option>Computer Science</option>
			                    <option>Electricals</option>
			                    <option>Electronics</option>
			                    <option>Finance</option>
			                    <option>Management</option>
			                    <option>Biotech</option>
			                </select>
			            </div>
			            <div class="col-xs-6">
			                <input type="text" placeholder="Sub-category" class="form-control tb-skill">
			            </div>
		        	</div>
		        	<br/>
		        	<div class="row">
			            <div class="col-xs-12">
			                <textarea placeholder="Description" class="form-control tb-desc"></textarea>
			            </div>
		        	</div>
		        	<br/>
		        	<div class="row">		        		
			            <div class="col-xs-6">
			                <input type="text" id="schedule-date" disabled placeholder="Date" class="form-control tb-date">
			            </div>
			            <div class="col-xs-3">		                
			                 <input id="basic1" type="text" class="form-control time" />
				            <script>
				                $(function() {
				                    $('#basic1').timepicker();
				                });
				            </script>
			            </div>
			            <div class="col-xs-3">		                
			               <input id="basic2" type="text" class="form-control time" />
				            <script>
				                $(function() {
				                    $('#basic2').timepicker();
				                });
				            </script>
			            </div>
		        	</div>
		        	<br/>
		        	<div class="row">		        		
			            <div class="col-xs-12">
			                <input type="text" id="autocomplete" onFocus="geolocate()" 
			                	placeholder="Enter the locatoin" class="form-control tb-loc">			                
			            </div>
		        	</div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default hide-modal">Close</button>
                    <button type="button" class="btn btn-primary" id="submit-request">Submit</button>
                </div>
            </div>

        </div>

    </div>



	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    
    <script src="scripts/bootstrap.min.js"></script>
	
    <script type="text/javascript">

		var lat = "";
		var lon = "";
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
			
			$.ajax({
		  	    url: "NotificationController",
		  	    type: "post",
		  	  	dataType: "JSON",
		  	    data: { 
		  	    		user_id: qs["currentUser"]
		  	    	},
				success: function(result) {
					updateCal(result);
				},
				error: function(result)
				{
					//alert("error");
				}
		  	});	
				
			$(document).delegate("#submit-request", "click", function (){
							
				var cat = $(".select-cat").prop("value");
				var subCat = $(".tb-skill").prop("value");
				var dateVal = $("#schedule-date").prop("value");
				var stTime = $('#basic1').prop("value");
				var endTime = $('#basic2').prop("value");
				var desc = $(".tb-desc").prop("value");
				var location = $('.tb-loc').prop("value");
				
				if (location == "")
				{
					lat = "";
					lon = "";
				}
				if (stTime == "")
				{
					stTime = "00:00 AM";	
				}
				else
				{
					stTime = ("0" + stTime).slice(-7);
					stTime = stTime.substr(0, 5) + " " + stTime.slice(-2);
					stTime.toUpperCase();
				}
				if (endTime == "")
				{
					endTime = "00:00 AM";	
				}
				else
				{
					endTime = ("0" + endTime).slice(-7);
					endTime = endTime.substr(0, 5) + " " + endTime.slice(-2);
					endTime.toUpperCase();
				}
				
				$.ajax({
	          	    url: "rc",
	          	    type: "post",
	          	    data: { 
	          	    		user_id: qs["currentUser"],
	          	    		cat: cat, subCat: subCat, dateVal: dateVal, stTime: stTime, 
	          	    		endTime: endTime, desc: desc, lat: lat, longi: lon, location: location
	          	    	},
					success: function(result) {
						$("#myModal").hide();
						
						
					},
					error: function(result)
					{
						//alert("error");
					}
	          	});	
			});
	    });
	    
	    function updateCal(result)
	    {
	    	for (i = 0; i < result.userNotificationList.length; i++)
	    	{
		    	$('#calendar').fullCalendar('renderEvent',
	   	        	{
	   	             id: result.userNotificationList[i].notificationId,
	   	             title: result.userNotificationList[i].skillName,
	   	             start: result.userNotificationList[i].startDate,
	   	             end: result.userNotificationList[i].startDate,	   	             	   	             
	   	          	 location: result.userNotificationList[i].location,
			   	   	 schTime: result.userNotificationList[i].time,			   	   	
			   	   	 sesnTo: result.userNotificationList[i].tutorName,
			   	   	 sesnFrm: result.userNotificationList[i].requestedUserName,
			   	   	 desc: result.userNotificationList[i].description
	   	         	},
	   	         	true // make the event "stick"
   	       		);	
	    	}
	    }
	    
    </script>
</body>
</html>