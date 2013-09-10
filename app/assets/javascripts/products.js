$(document).ready(function() {

  $('.searchform').on('submit', function(e) {
    e.preventDefault();
    $('.results').slideDown('fast');
    var keywords = $(this).children().first().val();
    $.ajax({
      method: 'POST',
      url: '/products',
      data: {"query": keywords}
    }).success(function(response) {
      $('.results').html(response);
      $('.result_item').fadeIn(1000);
    })
  });

  $('.results').on('click', '.research', function() {
    $.ajax({
      method: 'POST',
      url: '/products/research',
      data: {"link": $(this).attr('value')}
    }).success(function(response) {
      console.log('holla');
    })
  });

  $(document).on('click', function(e) {
    if(e.target.tagName == "BODY") {
      $('.results').hide();
    } else if (e.target.tagName == "INPUT") {
      if($('.results').html().length != 3) {
        $('.results').show();
      }
    }
  })

  $(".results").on("click", '.modal-link',function(){
    $(".modal-overlay").show();
    $(".modal-window").show();
    
     
    var docHeight = $(document).height(),
        winWidth = $(window).width(),
        winHeight = $(window).height(),
        modal = $(".modal-window"),
        overlay = $(".modal-overlay"),
        modalWidth = modal.outerWidth(),
        modalHeight = modal.outerHeight();
       
    modal.css({
      "top": centerVertically(winHeight,modalHeight, $(window).scrollTop()),
      "left": centerHorizontally(winWidth, modalWidth)});
    
    checkOverlay(winWidth, $(".container").outerWidth(), winHeight, docHeight);

    function checkOverlay(windowWidth, containerWidth, windowHeight, dHeight) {
        overlay.css({
          width: setOverlayWidth(windowWidth, containerWidth),
          height: setOverlayHeight(windowHeight, docHeight),
          left: 0
        });   
    }
    
    function setOverlayWidth(windowWidth, containerWidth){
       if(windowWidth >= containerWidth){
         return windowWidth;
       } else {
         return containerWidth;
       }
    }
    
    function setOverlayHeight(windowHeight, docHeight){
       if(windowHeight >= $("body").outerHeight() && docHeight > $("body").outerHeight()){
          return windowHeight;
       } else {
         return docHeight;
       }
    }
     
     function centerVertically(w, m, scroll){
      return ((w - m)/2 + scroll); 
     };
     
     function centerHorizontally(w, m){
      return (w - m)/2;
     }
     
     function checkHeight(windowHeight, scrollPosition){
      if(windowHeight < modalHeight){
       modal.css("top", scrollPosition);
      } else {
       modal.css("top", centerVertically(windowHeight,modalHeight,scrollPosition));
      }
     }
    
    function checkWidth(windowWidth, modalWidth){
      if(windowWidth < modalWidth){
       modal.css("left", 0);
      } else {
       modal.css("left", centerHorizontally(windowWidth,modalWidth));
      }
     }
       
     $(window)
       .resize(function() {
        checkWidth($(this).width(), modalWidth);
        checkHeight($(this).height(), $(this).scrollTop());
         checkOverlay($(this).width(), $(".container").outerWidth(), $(this).height(), $(document).height());
     })
       .scroll(function() {
        checkHeight($(this).height(), $(this).scrollTop());  
     });  
    
    $(".close-button").click(function(){
      $(".modal-overlay").hide();
      $(".modal-window").hide();
    });

    $.ajax({
      method: 'POST',
      url: '/products/research',
      data: {"link": $(this).attr('value')}
    }).success(function(response) {
      $('.results').css('display', 'none');
      $("input[type='text']").css('background', '#F1F1F1');
      $('.review-pane').html(response);
      $('.review-pane').show();
      $(".modal-overlay").hide();
      $(".modal-window").hide();
    })
  });
})

// var lastId,
//     topMenu = $("#Navigation"),
//     topMenuHeight = topMenu.outerHeight()+0,
//     menuItems = topMenu.find("a"),
//     scrollItems = menuItems.map(function(){
//       var item = $($(this).attr("href"));
//       if (item.length) { return item; }
//     });

// function highlightNav() {
//   var fromTop = $(window).scrollTop()+topMenuHeight;
//   var cur = scrollItems.map(function(){ if ($(this).offset().top < fromTop) { return this; } });
//   cur = cur[cur.length-1];
//   var id = cur && cur.length ? cur[0].id : "";
// //  console.log("id",id);
//   if (lastId !== id) {
//       lastId = id;
//       // Set/remove active class
//       menuItems
//         .removeClass("is-Current")
//         .filter("[href=#"+id+"]").addClass("is-Current");
//   }
// }
// highlightNav();
// $(window).scroll( highlightNav );



