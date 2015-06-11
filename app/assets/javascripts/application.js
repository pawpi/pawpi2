// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require leebc.js
//= require populateDiv.js




$(function(){
  $.ajaxSetup({
    beforeSend: function( xhr ) {
      var token = $('meta[name="csrf-token"]').attr('content');
      if (token) xhr.setRequestHeader('X-CSRF-Token', token);
    }
  });
});

$.fn.serializeObject = function() {
  var values = {};
  $("form input, form select, form textarea").each( function(){
    values[this.name] = $(this).val();
  });
  
  return values;
};
 
 
$(function(){
  $("form#sign_up_user").submit(function(e){
     e.preventDefault(); //This prevents the form from submitting normally
     var user_info = $(this).serializeObject();
     console.log("About to post to /users: " + JSON.stringify(user_info));
     $.ajax({
       type: "POST",
       url: "/users",
       data: user_info,
       dataType: "json",
       success: function(json){
		 jQuery.noConflict();
	     $('#registerModal').modal('toggle');
       },
       error: function(json){
       	alert("failure");
       },
       dataType: "json"
     });
  });
});



