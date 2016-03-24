$(document).ready(function() {
  if($('#clusterizeScrollArea').length && $('#clusterizeContentArea').length) {
    var clusterize = new Clusterize({
      scrollId: 'clusterizeScrollArea',
      contentId: 'clusterizeContentArea'
    });
  };

  $('.toggleCheckbox').click(function() {
    var checkbox = $(this).children('input[type=checkbox]');
    checkbox.prop('checked', !checkbox.prop('checked'));
    $(this).toggleClass('active');
  });

  tinymce.init({
    selector: '.wysiwyg',
    menubar: false
  });
});
