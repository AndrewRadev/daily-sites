//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$.fn.dump = function() {
  console.log(this);
  return this;
};

function dailyPath(day) {
  return '/sites/daily/' + day;
}

$(document).ready(function() {
  $('#open-links').click(function() {
    $('a.js-link').each(function() {
      window.open(this.href, '_blank');
    });

    return false;
  });

  $('.day-select a').click(function(e) {
    e.preventDefault();
    var day = $(this).data('id');
    document.location.href = dailyPath(day);
  });

  $('.js-favicon').on('error', function() {
    $defaultFavicon = $('.js-default-favicon');
    $(this).attr('src', $defaultFavicon.attr('src'));
  });
});
