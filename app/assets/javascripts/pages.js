var previousScroll = 0;
var head_top = 100;
var dis_top = 200;

document.addEventListener("turbolinks:load", function() {
  $('.page-scroll').click(function() {
    var position_div = $(this).attr('href');
    if(position_div == '#home'){
      $('html, body').stop().animate({scrollTop: 0}, 1000);
    } else {
      var position_top = $(position_div).position().top;
      $('html, body').stop().animate({scrollTop: position_top - 50}, 1000);
    }
    return false;
  });


  $(window).on('scroll', function(){
    var scroll_top = $(window).scrollTop();
    var book_library_top = $('#book_library').position().top;
    var about_top = $('#about').position().top;
    var feed_back_top = $('#feed_back').position().top;
    if (scroll_top < book_library_top -dis_top) {
      $('.page-scroll').parent().removeClass('active');
      $('#_home').addClass('active');
    }
    else if (about_top - dis_top > scroll_top && scroll_top > book_library_top - dis_top) {
      $('.page-scroll').parent().removeClass('active');
      $('#_book_library').addClass('active');
    }
    else if (feed_back_top - dis_top > scroll_top && scroll_top > about_top - dis_top) {
      $('.page-scroll').parent().removeClass('active');
      $('#_about').addClass('active');
    }
    else if (scroll_top > feed_back_top - dis_top) {
      $('.page-scroll').parent().removeClass('active');
      $('#_feed_back').addClass('active');
    }
    if (scroll_top > head_top) {
      $('#mainNav').addClass('color-header');
    } else {
      $('#mainNav').removeClass('color-header');
    }
  });

  var flash = function(){
    setTimeout(function(){
      $('#flash').slideUp(1000);
    }, 1500);
  };
  $(document).ready(flash);
  $(document).on('page:load', flash);
  $(document).on('page:change', flash);

  function myFunction(id) {
    var x = document.getElementById(id);
    if (x.className.indexOf("w3-show") == -1) {
      x.className += " w3-show";
      x.previousElementSibling.className += " w3-theme-d1";
    } else {
      x.className = x.className.replace("w3-show", "");
      x.previousElementSibling.className =
      x.previousElementSibling.className.replace(" w3-theme-d1", "");
    }
  }

  function openNav() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("w3-show") == -1) {
      x.className += " w3-show";
    } else {
      x.className = x.className.replace(" w3-show", "");
    }
  }
});

function myFunction(id) {
  var x = document.getElementById(id);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
    x.previousElementSibling.className += " w3-theme-d1";
  } else {
    x.className = x.className.replace("w3-show", "");
    x.previousElementSibling.className =
    x.previousElementSibling.className.replace(" w3-theme-d1", "");
  }
}

function openNav() {
  var x = document.getElementById("navDemo");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
}
