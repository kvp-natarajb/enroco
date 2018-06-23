// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require bootstrap-notify
//= require jquery.remotipart
//= require_self


// bootstrap notify feature

$(document).on('turbolinks:load', function () {

  var n_msg = $('.notice').html()
  var a_msg = $('.alert').html()
  if(n_msg != ""){
    show_notify(n_msg, "info")
  }
  if(a_msg != ""){
    show_notify(a_msg, "danger")
  }
});


function show_notify(msg, _type){
  $.notify({
    // options
    message: msg,
  },{
    // settings
    type: _type
  });
}


$(document).ready(function()
{
	$('#job-id-container').bind('DOMNodeInserted', function() {
		 queryForPercentage();
	});

	 var queryForPercentage;

	 queryForPercentage = function() {
      var job_id;
      job_id = $('#job_id').text(); // grabbing the job_id
      // console.log('sending ' + job_id + 'to /percentage_done');
      return $.ajax({
        url: "/skus/percentage_done", // sending an ajax request to /percentage_done
        data: {
          job_id: job_id // using the job_id from the DOM
        },
        success: function(data) { // The code in the 'success' function will execute after a successful call to the percentage_done controller
          var percentage;
          percentage = 'width: ' + data['percentage_done'] + '%;';
          // writing the percentage done to the progress bar
          $('#job-progress').attr('style', percentage).text(data['percentage_done'] + '%');
          // console.log(data['percentage_done']);
          // // unless the job-progress is 100% I want to recursively call the same function after 1.5 seconds.
          // // which resend the request to my percentage_done action
          if ($('#job-progress').text() !== '100%') {
            return setTimeout(queryForPercentage, 1500);
          }

          if ($('#job-progress').text() == '100%') {
             show_notify('<strong>Data has been saved successfully. Please check your mail.</strong>', 'success')
          }
        }
      });
    };
});





