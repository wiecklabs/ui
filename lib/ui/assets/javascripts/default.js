function deleteWithModal(link) {
  modal = $("#delete_modal");
  modal.load(link.href);
  openModal(modal);
  return false;
}

function openModal(content) {
  content.modal();
  $(window).keyup(function(e) { if ( e.keyCode == 27 ) closeModal(); });

  if($.browser.msie && $.browser.version < 7)
  {
	  var delete_modal = $("#modalContainer")
			
	  if ( !delete_modal.get(0) )
	    return false;
	
	  var original_top = document.documentElement.scrollTop + (document.documentElement.clientHeight / 2) - (delete_modal.outerHeight() / 2);
	  delete_modal.css({top: '' + original_top + 'px' })
  }
}

function closeModal() {
  $(window).unbind('keyup');
  $('.modalClose').click();
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