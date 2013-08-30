$(document).ready(function() {
  $('.searchform').on('submit', function(e) {
    e.preventDefault();
    $('.results').slideDown('fast');
    var keywords = $(this).children().first().val();
    $.ajax({
      method: 'POST',
      url: '/products',
      data: {"query": keywords}
    }).success(function(response) {
      $('.results').html(response);
      $('.result_item').fadeIn(1000);
    })
  })
})