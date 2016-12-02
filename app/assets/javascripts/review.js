document.addEventListener("turbolinks:load", function() {
  $('.nht-review-rate i').mouseover(function(evt){
    var name = this.className.split('-');
    var number = parseInt(name[name.length-1]);
    if (isNaN(number)) {
      number = 0;
    }
    number++;
    $('.nht-review-rate i').removeClass('nht-star');
    var a = $(this);
    for (var i = 0; i < number; i++) {
      a.addClass('nht-star');
      a = a.prev();
    }
    document.getElementById('review_rate').value = number;
  });
});
