function closeModal() {
  $(window).unbind('keyup');
  $('.modalClose').click();
}

function openModal(anchor) {
  modal = $('#modal');
  modal.load(anchor.href);
  modal.modal();
  $(window).keyup(function(e) { if (e.keyCode == 27) closeModal(); });
  return false;
}