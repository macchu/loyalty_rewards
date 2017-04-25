$( document ).ready(function() {

  $( ".field-name-field-highlight-image" ).hover(function() {
    var attribution = "#" + $(this).attr('id')+ '-attribution-popup';
    $( attribution ).toggle();
  });

});