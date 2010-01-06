function openModal(content) {
  content.modal();

  var height = $(window).height();
  var width = $(document).width()

  if (arguments.length >= 2) {
    if (arguments[1] >= 1) {
      var containerHeight = arguments[1];
    } else {
      var containerHeight = height * arguments[1];
    }
  } else {
    var containerHeight = height * 0.7;
  }
  
  var containerTop = ($.browser.msie && $.browser.version < 7 ? $(window).scrollTop() : 0) + (height / 2) - (containerHeight / 2);

  if (containerTop < 1) { containerTop = 1 }

  $("#modalContainer").css("height", containerHeight + "px")
  $('#modalContainer').css("top", containerTop + "px");
  
  if (arguments.length >= 3) {
    if (arguments[2] >= 1) {
      var containerWidth = arguments[2];
    } else {
      var containerWidth = width * arguments[2] ;
    }
  } else {
    var containerWidth = 770;
  }
  
  var containerLeft = (width / 2) - (containerWidth / 2);  
    
  $("#modalContainer").css("width", containerWidth + "px")
  $('#modalContainer').css("left", containerLeft + "px");  
    
  $(document).keyup(function(e) { if ( e.keyCode == 27 ) closeModal(); });
}

function closeModal() {
  $(window).unbind('keyup');
  $('.modalClose').click();
}

function bindSelectable() {
  $('.selectable').live("click", function(e) {
			if (e.target.nodeName == 'A' || e.target.nodeName == 'IMG')
				return true;

      checkbox = $(':checkbox', $(this))[0];
			if (e.target.nodeName != 'INPUT')
				checkbox.checked = !checkbox.checked

			if ( checkbox.checked ) {
				$(this).addClass('selected');
			}
			else $(this).removeClass('selected');

			updateBatch();
    });

  $('.selectable :checkbox').live("click", updateBatch);
}

// Repositions the actions bar on load and on scroll.
function fix_actions_bar_for_ie6() {

  var reposition_bar = function() {
    var actions = $('form .actions');

    if (!actions.get(0)) {
      return false;
    }

    var top = $(window).scrollTop() + $(window).height() - actions.outerHeight();
    var width = $(window).width();

    actions.css({ position: 'absolute', bottom: '', top: '' + top + 'px' }).width(width);
  };

  reposition_bar();

  $(window).scroll(reposition_bar);

  var resizeTimer = null;
  $(window).bind('resize', function() {
    if (resizeTimer) {
      clearTimeout(resizeTimer);
    }
    resizeTimer = setTimeout(reposition_bar, 100);
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

  var actions = $('form .actions');
  if (actions) {
    // Insert a spacer to account for the fixed actions bar.
    $('body').append('<div id="actions-spacer" style="height: ' + (actions.outerHeight() + 4) + 'px;">&nbsp;</div>');
  }

  if ($.browser.msie && /^6/.test($.browser.version)) {
    png_fix_for_ie6();

    fix_actions_bar_for_ie6();
  }

  modalize_links();

});
