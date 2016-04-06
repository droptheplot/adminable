$(document).ready(function() {
  if($('#clusterizeScrollArea').length && $('#clusterizeContentArea').length) {
    var clusterize = new Clusterize({
      scrollId: 'clusterizeScrollArea',
      contentId: 'clusterizeContentArea'
    });
  }

  $('.uncheck-associations').click(function() {
    var inputs = $(this).parent().next().next('.associations').find('input[type=radio], input[type=checkbox]');
    inputs.each(function(index, value) {
      value.checked = false;
    });
  });

  tinymce.init({
    selector: '.wysiwyg',
    menubar: false,
    statusbar: false
  });

  $('[data-toggle="tooltip"]').tooltip();
});
