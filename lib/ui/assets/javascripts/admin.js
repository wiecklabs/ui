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

function bindSelectable() {
  $('.selectable')
    .click(function(e) {
      checkbox = $(':checkbox', $(this))[0];

			if ( checkbox.checked ) {
				$(this).addClass('selected');
			}
			else $(this).removeClass('selected');

      if ( e.target.nodeName == "TD" ) checkbox.click();
    });

  $('.selectable :checkbox').click(updateBatch);
}