function openModal(content) {
  content.modal();
  $(window).keyup(function(e) { if ( e.keyCode == 27 ) closeModal(); });
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

// Repositions the actions bar on load and on scroll.
function fix_actions_bar_for_ie6() {
  var actions = $('form .actions');

  if (!actions.get(0)) {
    return false;
  }

  var original_top = document.documentElement.clientHeight - actions.outerHeight();
  var width = document.documentElement.clientWidth;

  actions.css({ position: 'absolute', bottom: '', top: '' + original_top + 'px' }).width(width);
  $(window).scroll(function(e) {
    var scroll_top = document.documentElement.scrollTop;
    actions.css({ top: (scroll_top + original_top) + 'px' });
  });
}

// Modal behavior for modalized links.
function modalize_links() {
  $('.modal_link').click(function() {
    m = $("#modal");
    m.load(this.href);
    openModal(m);
    return false;
  });
}

// Applies png fix to specified selectors.
function png_fix_for_ie6() {
  // Requires 'javascripts/DD_belatedPNG_0.0.8a-min.js asset included in layout
  // Fix the 'close' png image used on modal dialogs.
  DD_belatedPNG.fix('#modalContainer a.modalCloseImg');
}

$(document).ready(function() {

  if ($.browser.msie && /^6/.test($.browser.version)) {
    png_fix_for_ie6();

    fix_actions_bar_for_ie6();
  }

  modalize_links();

});
