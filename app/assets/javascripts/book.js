document.addEventListener('turbolinks:load', function() {
  $('.multi-item-carousel').carousel({
    interval: false
  });

  $('.multi-item-carousel .item').each(function(){
    var next = $(this).next();
    if (!next.length) {
      next = $(this).siblings(':first');
    }
    next.children(':first-child').clone().appendTo($(this));

    if (next.next().length>0) {
      next.next().children(':first-child').clone().appendTo($(this));
    } else {
      $(this).siblings(':first').children(':first-child').clone().appendTo($(this));
    }
  });

  var rate_five = $('.five .bar').data('id');
  var rate_four = $('.four .bar').data('id');
  var rate_three = $('.three .bar').data('id');
  var rate_two = $('.two .bar').data('id');
  var rate_one = $('.one .bar').data('id');
  var sum = rate_five + rate_four + rate_three + rate_two + rate_two;
  if (sum == 0) {
    $('.five .bar').width(0);
    $('.four .bar').width(0);
    $('.three .bar').width(0);
    $('.two .bar').width(0);
    $('.one .bar').width(0);
  } else {
    $('.five .bar').css("width", (rate_five / sum)*80 + '%');
    $('.four .bar').css("width", (rate_four / sum)*80 + '%');
    $('.three .bar').css("width", (rate_three / sum)*80 + '%');
    $('.two .bar').css("width", (rate_two / sum)*80 + '%');
    $('.one .bar').css("width", (rate_one / sum)*80 + '%');
  }
});