// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//$('p#notice, p#warning, p#error').fadeOut(5000)
$(document).ready(function() {
  setTimeout(hideFlashMessages, 10000);
});

function hideFlashMessages() {
  $('div#flash-notice, div#flash-warning, div#flash-error').fadeOut(5000)
}

