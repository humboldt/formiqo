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

  // $.getScript('https://www.paypalobjects.com/api/checkout.js', function() {})

  var preparePayButton = function () {
    // if ($('#paypal-button').length) {

    // $.getScript('https://www.paypalobjects.com/api/checkout.js', function() {
      var CREATE_PAYMENT_URL  = 'http://localhost:3000/checkout';
      var EXECUTE_PAYMENT_URL = 'http://localhost:3000/execute';

      paypal.Button.render({

          env: 'sandbox', // Or 'sandbox'

          commit: true, // Show a 'Pay Now' button
          style: {
              label: 'pay', // checkout | credit | pay
              size:  'small',    // small | medium | responsive
              shape: 'rect',     // pill | rect
              color: 'blue'      // gold | blue | silver
          },
          payment: function() {
              return paypal.request.post(CREATE_PAYMENT_URL).then(function(data) {
                  return data.paymentID;
              });
          },

          onAuthorize: function(data) {
              return paypal.request.post(EXECUTE_PAYMENT_URL, {
                  paymentID: data.paymentID,
                  payerID:   data.payerID
              }).then(function(res) {
                // console.log(res);
                // window.alert("Payment is compelete")
                  // The payment is complete!
                  // You can now show a confirmation message to the customer
              });
          }

      }, '#paypal-button');

      // $('#loading-pay-btn').css('display', 'none')
      // $('#paypal-button').css('display', 'block')
    // })

  }

  // if (window.location.pathname == "/subscriptions") {
  //   preparePayButton()subscribe
  // }

  $('.plan').click(function() {
    let id = $(this).attr('id')
    $('#subscription_plan_id').val(id)
  })

  $("#subscribe").on('click', function() {
    $(this).css('display', 'none')
    $("#loading-pay-btn").css('display', 'block')
  })


})
