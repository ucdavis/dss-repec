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
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-ui/datepicker
//= require jquery.datetimepicker/init
//= require activestorage
//= require popper
//= require_tree .


jQuery(function ($){
  $('#datepicker').datepicker({
    dateFormat: "yy-mm-dd"
  });
});

jQuery(function ($){
  $('#check_all').on("click", function(){
    var cbxs = $('input[type="checkbox"]');
    cbxs.prop("checked", !cbxs.prop("checked"));
  });
});

function toggleButton() {
    var change = document.getElementById("check_all");
    if (change.innerHTML == "Select all"){
        delete_all_btn.style.display="block";
        change.innerHTML = "Deselect all";
    } else {
        delete_all_btn.style.display="none";
        change.innerHTML = "Select all";
    }
}

function validateFiles(inputFile) {
  //var maxExceededMessage = "This file exceeds the maximum allowed file size (5 MB)";
  var extErrorMessage = "Only image file with extension: .jpg, .jpeg, .gif or .png is allowed";
  var allowedExtension = "pdf";

  var extName;
  //var maxFileSize = $(inputFile).data('max-file-size');
  // var sizeExceeded = false;
  var extError = false;

  // $.each(inputFile.files, function() {
    // if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = this.name.split('.').pop();
    if (extName != allowedExtension) {extError=true;};
  // });
  // if (sizeExceeded) {
  //   window.alert(maxExceededMessage);
  //   $(inputFile).val('');
  // };

  if (extError) {
    window.alert(extErrorMessage);
    $(inputFile).val('');
  };
}
