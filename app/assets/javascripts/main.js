/* ==========================================================================
    Sticky header
========================================================================== */
$(window).scroll(function(){
    var headerHeight = $("#header").height();
    var navbarHeight = $(".navbar-scroll-fixed").height();
    var headerOffset;
    var nsf = $('.navbar-scroll-fixed');

    if($('.logo-section-wrapper').is(':visible')) {
        headerOffset = headerHeight - navbarHeight;
    }else {
        headerOffset = $('.top-header').height();
    }

    if($(this).scrollTop() >  headerOffset) {
        nsf.addClass('navbar-scrolled');
    }else {
        nsf.removeClass('navbar-scrolled');
    }
});

/* ==========================================================================
    Navbar collapse
========================================================================== */
$('.navbar-onepage .navbar-nav>li>a').on('click', function(){
    if($('.navbar-toggle').css('display') !='none'){
        $(".navbar-toggle").trigger( "click" );
    }
});

/* ==========================================================================
    Partners Carousel
========================================================================== */
$('.partners-carousel').owlCarousel({
    loop:true,
    autoplay:true,
    autoplayHoverPause: true,
    margin:80,
    nav:true,
    navText: ["<i class='fa fa-long-arrow-left'></i>","<i class='fa fa-long-arrow-right'></i>"],
    responsive:{
        0:{
            items:2
        },
        480:{
            items:3
        },
        720:{
            items:4
        },
        1000:{
            items:6
        }
    }
})

/* ==========================================================================
    Testimonials Carousel
========================================================================== */
$('.testimonials-carousel').owlCarousel({
    loop:true,
    autoplay:true,
    autoplayHoverPause: true,
    margin:80,
    nav:true,
    navText: ["<i class='fa fa-chevron-left fa-2x'></i>","<i class='fa fa-chevron-right fa-2x'></i>"],
    items: 1
})

/* ==========================================================================
    Google Maps
========================================================================== */
function googleMap () {
    if ($('.contact-gmap').length) {
        $('.contact-gmap').each(function () {
            // Get data from html 
            var Id = $(this).attr('id');
            var Lat = $(this).data('latitude');
            var Lng = $(this).data('longitude');
            var Icon = $(this).data('icon');
            var Zoom = $(this).data('zoom');
            var markers = $(this).data('markers');
            var Title = $(this).data('map-title');
            
            // Set default zoom value to 10
            if (!Zoom) {
                var Zoom = 10;
            };
            // Map initialization
            var map;
            map = new GMaps({
                div: '#'+Id,
                lat: Lat,
                lng: Lng,
                zoom: Zoom,
                title: Title,
                scrollwheel: false //disable zooming when scrolling on page
            });
            // Check if icon exist to add the marker
            if(Icon) {
                $.each(markers, function (index, value) {
                    var index = value;
                    var html;
                    if (index[2]) {
                        html = index[2];
                    };                    
                    if (index[3]) {
                        iconPath = index[3];
                    };
                    map.addMarker({
                        icon: Icon,                        
                        lat: index[0],
                        lng: index[1],
                        infoWindow: {
                          content: html
                        }
                    });   
                });
            }
        });  
    };
}

// Calling the googleMap method when the page is loaded   
jQuery(document).on('ready', function () {
    (function ($) {
        googleMap();
    })(jQuery);
});

/* ==========================================================================
    Services Tab
========================================================================== */
$('.services-tabs li a').on('click', function(){
    if($('.services-nav-collapse').is(":visible"))
    {
        $('.services-nav-collapse').click();
    }
});

/* ==========================================================================
    Product page quantity Plus/Minus
========================================================================== */
$('.plus').on('click',function(){
    var $qty = $(this).parent('.quantity').find('#qty');
    var Val = parseInt($qty.val());
    if (!isNaN(Val)) {
        $qty.val(Val + 1);
    }
});
$('.minus').on('click',function(){
    var $qty=$(this).parent('.quantity').find('#qty');
    var Val = parseInt($qty.val());
    if (!isNaN(Val) && Val > 0) {
        $qty.val(Val - 1);
    }
});

/* ==========================================================================
    Products Carousel
========================================================================== */
$('.products-carousel').owlCarousel({
    autoplay:true,
    dots:false,
    autoplayHoverPause: true,
    margin:30,
    nav:false,
    responsive:{
        0:{
            items:1
        },
        480:{
            items:2
        },
        720:{
            items:3
        },
        1000:{
            items:4
        }
    }
})

/* ==========================================================================
    Add smooth scrolling to all links
========================================================================== */
$(document).ready(function(){
  // Add smooth scrolling to all links
  $("a").on('click', function(event) {

    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 800, function(){
   
        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
});