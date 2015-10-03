//= require jquery
//= require jquery_ujs

$.fn.log = function() {
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

  $('.day-select').change(function() {
    var day = $(this).val();
    document.location.href = dailyPath(day);
  });
});
