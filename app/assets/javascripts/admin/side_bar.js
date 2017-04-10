document.addEventListener("turbolinks:load", function() {
  if ($('.nht-admin-category-index').length) {
    $('.sidebar-menu li').removeClass('active');
    $('.nht-category').addClass('active');
  } else if($('.nht-admin-user-index').length) {
    $('.sidebar-menu li').removeClass('active');
    $('.nht-user').addClass('active');
  } else if($('.nht-admin-request-index').length) {
    $('.sidebar-menu li').removeClass('active');
    $('.nht-request').addClass('active');
  } else if($('.nht-admin-book-index').length) {
    $('.sidebar-menu li').removeClass('active');
    $('.nht-book').addClass('active');
  }
});
