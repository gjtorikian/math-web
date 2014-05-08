$(document).on('submit change keyup', 'form', function(e) {
  e.preventDefault();

  $('#result').show();

  var img = document.createElement('img');
  $(img).on('load', function() {
    $('#output').empty().append(img);
    $('#url').val(img.src);
  });

  img.src = this.action + '?' + $(this).serialize();
});
