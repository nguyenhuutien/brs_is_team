$(document).delegate('.nht-other-author', 'click', function(event){
  event.preventDefault();
  var id = $(this).children()[0].className;
  if($('.nht-admin-book-author-multi-' + id).is(":visible")) {
    $('.nht-admin-book-author-multi-' + id).hide();
    $('.nht-admin-book-author-single-' + id).show();
    $('.nht-admin-book-author-single-' + id).next().val('0');
    $('p.' + id).html('Cancel');
  } else {
    $('.nht-admin-book-author-multi-' + id).show();
    $('.nht-admin-book-author-single-' + id).hide();
    $('.nht-admin-book-author-single-' + id).next().val('1');
    $('p.' + id).html('Another author');
  }
});