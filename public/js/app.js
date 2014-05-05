$(document).on('submit change keyup', 'form', function(e) {
  e.preventDefault();

  $('#result').show();

  var img = document.createElement('img');
  img.src = this.action + '?' + $(this).serialize();
  $('#output').empty().append(img);
  $('#url').val(img.src);

  $(img).on('error', function() {
    $('#output').empty();
  });
});
