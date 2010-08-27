function deleteWithModal(link) {
  modal = $("#delete_modal");
  modal.load(link.href);
  openModal(modal);
  return false;
}

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