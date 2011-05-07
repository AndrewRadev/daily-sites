$(document).ready(function() {
  $('#open-links').click(function() {
    $('a.js-link').each(function() {
      window.open(this.href, '_blank');
    });

    return false;
  });
});
