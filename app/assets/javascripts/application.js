// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery

//= require rails-ujs
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function() {

  if ($('.notification').length) {
    setTimeout(function(){
      $('.notification').fadeOut();
    }, 5000)
  }
  $('.notification > button.delete').on('click', function(e) {
    e.preventDefault();
    $(this).closest('.notification').fadeOut();
  })
  $('.navbar-burger.burger').on('click', function(e) {
    e.preventDefault();
    $('.navbar-menu').slideToggle('fast');
  })

  $('.plan').click(function() {
    let id = $(this).attr('id')
    $('#subscription_plan_id').val(id)
  })

  $("#subscribe").on('click', function() {
    $(this).css('display', 'none')
    $("#loading-pay-btn").css('display', 'block')
  })


  $("#toggle-view").on('click', function(e) {
    e.preventDefault();
    $(".message-fields").toggle("fast")
  })

})
