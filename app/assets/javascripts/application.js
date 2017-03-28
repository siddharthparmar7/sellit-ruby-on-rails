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
// = require turbolinks
//= require bootstrap
//= require_tree .
//= require_self
//= require customJS


$(document).on('turbolinks:load', function() {
  var counter = 0;
  $('#filter-icon').click(function(){
    // $('.filter').css('display', 'block');
    if(counter == 0){
      $('.filter').slideDown('100');
      counter = 1;
    }
    else{
      $('.filter').slideUp('100');
      counter = 0;
    }
  });
});
