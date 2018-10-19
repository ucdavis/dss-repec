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
//= require rails-ujs
//= require jquery_ujs
//= require jquery3
//= require activestorage
//= require turbolinks
//= require popper
//= require bootstrap-sprockets
//= require_tree .

$ -> # do you have this?
  alert 'test'

$("#checkAll").select_all();

// Override the default confirm dialog of Rails
Rails.handleConfirm = link => {
  if (link.data('confirm') === undefined){
    return true
  }
  showSweetAlertConfirmationDialog(link)
  return false
}
