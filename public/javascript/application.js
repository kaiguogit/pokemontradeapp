$(document).ready(function() {

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  // $(".wish_list_button").click(function() {

  //   $("#pokemon_to_wish").val($(this).data("id"));

  //   $('form[name="wish_list_form"]').submit();

  // });
 //------pokedex search-----------
///-----change type drop down list style
  var update_chosen_item_class = function(){
    $('#type_bar_pokedex_chosen .active-result').each(function(i, list_item){
      text = list_item.innerHTML.toLowerCase();
      $(list_item).addClass("background-color-" + text);
      $(list_item).addClass("pokemon-type-tag-dropdown");
    });
  }
///-----
  //update pokedex by search box 
  var name_input = $('#search_bar_pokedex');
  var type_input = $('#type-bar-pokedex');
  var wish_list_gl;
  //var name_input = document.getElementById('search-pokemon');
   // name_input = $(name_input);

   name_input.keyup(function(){filter_pokemon()});
  // name_input.chosen().change(function(){
  //   filter_pokemon();
  // });
  $(type_input).on('chosen:showing_dropdown', function(evt, params) {
    update_chosen_item_class();
  });
  $(type_input).chosen({max_selected_options: 2}).change(function(){
    filter_pokemon();
  });
  

  update_chosen_item_class();

var filter_pokemon = function(){
      var name_filter = name_input.val().toUpperCase();
      var type_filter = type_input.val();
      var lis = $('.col-pokedex');
      lis.each(function(i,l){
        var $l = $(l)
        if($l.find('.caption').length == 0){
          return true;
        }
        var name = $l.find('.caption').html().trim();
        // var type = $l.find('[class^=background-color-]');
        var types = $l.find('[class^=background-color]');
   
        if (name.toUpperCase().indexOf(name_filter) == 0 && filter_type(types, type_filter)){
          $l.show();
        }
        else{
          $l.hide();
        }
      });
      update_all_wishlist_cards(window.wish_list_gl);
      var lis = $('.listing-table-row');
      lis.each(function(i,l){
        var $l = $(l)
        var name = $l.find('.pokemon-for-sale-name').html().trim();
        // var type = $l.find('[class^=background-color-]');
        var types = $l.find('[class^=background-color]');
   
        if (name.toUpperCase().indexOf(name_filter) == 0 && filter_type(types, type_filter)){
          $l.show();
        }
        else{
          $l.hide();
        }
      });
  }

  var filter_type = function(types, type_filter){
    var result = false
    if (type_filter == null){
      return true
    }
    types.each(function(x,t){
      if (t.innerHTML == type_filter){
        result = true
      }
    });
    return result
  }

///---------------

  //------WishList Ajax

  var user_id = $('body').attr('data-user-id');
  var get_user_wishlist = function(){
    if (user_id != undefined) {
      $.ajax({
        url: '/api/user/' + user_id + '/wishlist',
        method: 'GET', // optional
        success: function(data) {
          window.wish_list_gl = data;

          wrap_wishlist_button(data);
          // for(var i = 0; i < data.length; i++) {
          //   render_review(data[i]);
          // }
        }
      });
    }
  }
  get_user_wishlist();

  var wrap_wishlist_button = function(wish_list){
    var lis = $('.col-pokedex');
    lis.each(function(i,l){
      var $l = $(l)
      // var name = $l.find('.caption').html().trim();
      var species_id = $l.attr('data-species-id');
      wrap_species_wishlist_button(species_id, wish_list);
      update_wishlist_cards(species_id, wish_list);
    });
  }  

var wrap_species_wishlist_button = function(species_id,wish_list){
  l = $("#pokedex .col-pokedex[data-species-id=" + species_id +"]");
  if (wish_list.indexOf(species_id) != -1){
    l.find('.wish_list_button').addClass("wish_list_button_liked");
    l.find('.wish_list_button_wrapper span.button-tooltiptext').text("Remove from Wishlist");
  }
  else{
    l.find('.wish_list_button').removeClass("wish_list_button_liked");
    l.find('.wish_list_button_wrapper span.button-tooltiptext').text("Add to Wishlist");
  }
}

var update_wishlist_cards = function(species_id,wish_list){
  l = $("#wish-list .col-pokedex[data-species-id=" + species_id +"]");
  if (wish_list.indexOf(species_id) != -1){
    l.show();
  }
  else{
    l.hide();
  }
}
var remove_wishlist_cards = function(species_id,wish_list){
  l = $("#wish-list .col-pokedex[data-species-id=" + species_id +"]");
  if (wish_list.indexOf(species_id) == -1){
    l.hide();
  }
}

var update_all_wishlist_cards = function(wish_list){
  var lis = $('#wish-list .col-pokedex');
  lis.each(function(i,l){
    var $l = $(l)
    // var name = $l.find('.caption').html().trim();
    var species_id = $l.attr('data-species-id');
    remove_wishlist_cards(species_id, wish_list);
  });
}

var update_collection_cards = function(pokemon_id,collection_list){
  l = $("#owned-pokemon-list .col-pokedex[data-pokemon-id=" + pokemon_id +"]");
  if (collection_list.indexOf(pokemon_id) != -1){
    l.show();
  }
  else{
    l.hide();
  }
}

// var remove_from_wish_list = function(species_id,wish_list){
//   l = $("#wish-list .col-pokedex[data-species-id=" + species_id +"]");
//   if (wish_list.indexOf(species_id) == -1){
//     l.hide();
//   }
// }

var update_to_wishlist = function(species_id,ele) {
    $.ajax({
      url: '/api/user/' + user_id + '/wishlist',
      type: 'POST',
      data: { species_id: species_id },
      success: function(wish_list) {
        window.wish_list_gl = wish_list;
        ele.attr('data-disabled',"false");
        ele.html('<span class=\'glyphicon glyphicon-heart\'></span>');
        wrap_species_wishlist_button(species_id, wish_list);
        update_wishlist_cards(species_id, wish_list);
      },
      error: function() {
      }
    });
  }
var remove_from_collection = function(pokemon_id,ele) {
    $.ajax({
      url: '/api/user/' + user_id + '/pokemons',
      type: 'DELETE',
      data: { pokemon_id: pokemon_id },
      success: function(collection_list) {
        ele.attr('data-disabled',"false");
        ele.html('<span class=\'glyphicon glyphicon-heart\'></span>');
        update_collection_cards(pokemon_id, collection_list);
      },
      error: function() {
      }
    });
  }
var remove_listing = function(listing_id,ele) {
  $.ajax({
    url: '/api/user/' + user_id + '/listings',
    type: 'DELETE',
    data: { listing_id: listing_id },
    success: function(listings) {
      ele.attr('data-disabled',"false");
      ele.html('<span class=\'glyphicon glyphicon-heart\'></span>');
      update_listing_list(listing_id, listings);
    },
    error: function() {
    }
  });
}

var update_listing_list = function(listing_id,listings){
  l = $("#trade-list .listing-item[data-listing-id=" + listing_id +"]");
  if (listings.indexOf(listing_id) != -1){
    l.show();
  }
  else{
    l.hide();
  }
}
//////wish_list_button_listener
  $('a.wish_list_button').click(function() {
    event.preventDefault();
    if($(this).attr('data-disabled') == "true"){
      return false;
    }
    var ele = $(this);
    var species_id = $(this).attr('data-species-id');
    //http://preloaders.net/en/free
    $(this).html('<img id=\"#loader-icon\" src=\"/images/loader-icon36-36.gif\">')
    $(this).attr('data-disabled',"true");
    update_to_wishlist(species_id,ele);
  });

////collection button listener

  $('a.remove_from_collection_button').click(function() {
    event.preventDefault();
    if($(this).attr('data-disabled') == "true"){
      return false;
    }
    var ele = $(this);
    var pokemon_id = $(this).attr('data-pokemon-id');
    //http://preloaders.net/en/free
    $(this).html('<img id=\"#loader-icon\" src=\"/images/loader-icon36-36.gif\">')
    $(this).attr('data-disabled',"true");
    remove_from_collection(pokemon_id,ele);
  });



 $('a.tab-link').click(function(){
  $(this).parent().siblings().removeClass('active');
  $(this).parent().addClass('active');
 });
  

////collection button listener

  $('a.remove_from_collection_button').click(function() {
    event.preventDefault();
    if($(this).attr('data-disabled') == "true"){
      return false;
    }
    var ele = $(this);
    var pokemon_id = $(this).attr('data-pokemon-id');
    //http://preloaders.net/en/free
    $(this).html('<img id=\"#loader-icon\" src=\"/images/loader-icon36-36.gif\">')
    $(this).attr('data-disabled',"true");
    remove_from_collection(pokemon_id,ele);
  });


  $('a.remove_listing_button').click(function() {
    event.preventDefault();
    if($(this).attr('data-disabled') == "true"){
      return false;
    }
    var ele = $(this);
    var listing_id = $(this).attr('data-listing-id');
    //http://preloaders.net/en/free
    $(this).html('<img id=\"#loader-icon\" src=\"/images/loader-icon36-36.gif\">')
    $(this).attr('data-disabled',"true");
    remove_listing(listing_id,ele);
  });

});

jQuery(document).ready(function($) {
  var user_id = $('body').attr('data-user-id');


  $('.popup-add-to-collection').magnificPopup({
  type:'inline',
  callbacks: {
    open: function() {
      el = $(this._lastFocusedEl);
      popup = this;
      popup_div = $('#add_to_collection_popup');
      species_id = el.attr('data-species-id');
      species_name = el.attr('data-species-name');
      species_url = el.attr('data-species-url');
      
      popup_div.find('#popup-species-image').html("<img class=\"thumbnail-image\" src=\""+ species_url +"\" alt=\"Bulbasaur\">");
      popup_div.find('#popup-species-name').html("<span>" + species_name + "</span>");
      popup_div.find('#popup-nick-name').html("<input class='form-control' type='text' id='name' name='name' value='"+ species_name+ "'>");

      popup_div.find('#popup-form').submit(function(){
        popup_div.find('#popup-message').html("");
        event.preventDefault();
        $form = $(this)
        $.ajax({
          url: $form.attr('action'),
          type: 'POST',
          data: {species_id: species_id, user_id: user_id, cp: $('#cp').val(), name: $('#name').val(), quick_move: $('#quick_move').val(), charge_move: $('charge_move').val()},
          success: function(data){
            popup_div.find('#popup-message').html("<span style=\"color: green;\">Success.</span>");
            setTimeout(function(){console.log(1);popup.close();}, 2000);
            location.reload();
          },
          error: function(){
            popup_div.find('#popup-message').html("<span style=\"color: red;\">Failed to added to collection.</span>");
            setTimeout(function(){console.log(1);popup.close();}, 2000);
          }
        });
      });
    },
    close: function() {
      // Will fire when popup is closed
    }
    // e.t.c.
  }
  });

//edit pokemon popup  
///////////// 

  $('.popup-edit-pokemon').magnificPopup({
  type:'inline',
  callbacks: {
    open: function() {
      el = $(this._lastFocusedEl);
      popup = this;
      popup_div = $('#edit_pokemon_popup');
      pokemon_id = el.attr('data-pokemon-id');
      pokemon_name = el.attr('data-pokemon-name');
      pokemon_url = el.attr('data-pokemon-url');
      species_name = el.attr('data-pokemon-species-name');
      pokemon_cp = el.attr('data-pokemon-cp');
      popup_div.find('#popup-species-image').html("<img class=\"thumbnail-image\" src=\""+ pokemon_url +"\" alt=\"Bulbasaur\">");
      popup_div.find('#popup-species-name').html("<span>" + species_name + "</span>");
      popup_div.find('#popup-nick-name').html("<input class='form-control' type='text' id='name' name='name' value='"+ pokemon_name+ "'>");
      popup_div.find('#popup-cp').html("<input class='form-control' type='text' id='cp' name='cp' value='"+ pokemon_cp+ "'>");
      console.log(this);

      popup_div.find('#popup-form').submit(function(){
        popup_div.find('#popup-message').html("");
        event.preventDefault();
        $form = $(this)
        $.ajax({
          url: $form.attr('action'),
          type: 'PUT',
          data: {pokemon_id: pokemon_id, user_id: user_id, cp: $('#cp').val(), name: $('#name').val(), quick_move: $('#quick_move').val(), charge_move: $('#charge_move').val()},
          success: function(data){
            console.log(data);
            update_pokemon_card(data);
            popup_div.find('#popup-message').html("<span style=\"color: green;\">Success.</span>");
            setTimeout(function(){console.log("closing popup");popup.close();}, 500);
            
          },
          error: function(){
            popup_div.find('#popup-message').html("<span style=\"color: red;\">Failed to edit this pokemon.</span>");
            setTimeout(function(){console.log("closing popup");popup.close();}, 500);
          }
        });
      });
    },
    close: function() {
      // Will fire when popup is closed
    }
    // e.t.c.
  }
  });

  var update_pokemon_card = function(data){
    l = $("#owned-pokemon-list .col-pokedex[data-pokemon-id=" + data.id +"]");
    l.find(".collection-pokemon-name").html(data.name);
    l.find(".collection-pokemon-cp").html(data.cp || "N/A");
    l.find(".collection-pokemon-qm").html("QM: " + (data.quick_move || "N/A") );
    l.find(".collection-pokemon-cm").html("CM: " + (data.charge_move || "N/A") );
  }
  

  ////add to trade list popup 

  $('.popup-add-to-trade-list').magnificPopup({
  type:'inline',
  callbacks: {
    open: function() {
      el = $(this._lastFocusedEl);
      popup = this;
      popup_div = $('#add_to_trade_list_popup');
      pokemon_id = el.attr('data-pokemon-id');
      pokemon_name = el.attr('data-pokemon-name');
      pokemon_url = el.attr('data-pokemon-url');
      species_name = el.attr('data-pokemon-species-name');
      pokemon_cp = el.attr('data-pokemon-cp');

      l = $("#owned-pokemon-list .col-pokedex[data-pokemon-id=" + pokemon_id +"]");

      popup_div.find('.thumbnail-wrapper').html(l.find('.thumbnail-wrapper').html());
      popup_div.find('.collection-pokemon-name').html(l.find('.collection-pokemon-name').html());
      popup_div.find('.collection-pokemon-cp').html(l.find('.collection-pokemon-cp').html());
      popup_div.find('.species-type-wrapper').html(l.find('.species-type-wrapper').html());
      console.log(this);
      popup_div.find('#popup-message').html("");
      popup_div.find('#popup-form').submit(function(){
        
        wishlist_array = popup_div.find('.trade-form-wish-list-item');
        wishlist_array = $(wishlist_array).filter(function(i,b){return ($(b.children).hasClass('listings-wishlist-user-owned')); });
        wishlist_array = jQuery.map(wishlist_array,function(a){return $(a).attr("data-species-id");});
        event.preventDefault();
        $form = $(this)
        $.ajax({
          url: $form.attr('action'),
          type: 'POST',
          data: {pokemon_id: pokemon_id, user_id: user_id, wish_list: wishlist_array, price: ($($form.find('#price')).val() * 100)},
          success: function(data){
            console.log(data);
            console.log("added to trade list");
            popup_div.find('#popup-message').html("<span style=\"color: green;\">"+ "Success" +".</span>");
            if(data.message != null){
              alert(data.message);
            }
            if(data.message == "Please Login or register to proceed."){
              // window.location.href = "/login";
              popup.close();
              window.location.replace("/login");
            }
            else{
            setTimeout(function(){console.log("closing popup");popup.close();}, 500);
            location.reload();
            }
          },
          error: function(){
            popup_div.find('#popup-message').html("<span style=\"color: red;\">Failed to add to trade list.</span>");
            setTimeout(function(){console.log("closing popup");popup.close();}, 500);
          }
        });
      });
    },
    close: function() {
      // Will fire when popup is closed
    }
    // e.t.c.
  }
  });

  $('.popup-checkout-button').magnificPopup({
  type:'inline',
  callbacks: {
    open: function() {
      el = $(this._lastFocusedEl);
      popup = this;
      popup_div = $('#checkout_popup');
      // pokemon_id = el.attr('data-pokemon-id');
      // pokemon_name = el.attr('data-pokemon-name');
      // pokemon_url = el.attr('data-pokemon-url');
      // species_name = el.attr('data-pokemon-species-name');
      listing_id = el.attr('data-listing-id');

      l = $(".listing-row[data-listing-id=" + listing_id +"]");
      owned_list = l.find('.listings-wishlist-user-owned')
      owned_list = jQuery.map(owned_list,function(a){return $(a).attr('data-species-id')})
      user_owned_list = popup_div.find(".listing-wish-list-popup")
      $(user_owned_list).each(function(i,p){
        if( owned_list.indexOf($(p).attr("data-species-id")) == -1){
          $(p).hide();
        }else{
          $(p).show();
        }
      });
      var pokemon_url = l.attr('data-pokemon-url');
      var pokemon_name = l.attr('data-pokemon-name');
      var pokemon_cp = l.attr('data-pokemon-cp');
      var pokemon_price = l.attr('data-pokemon-price');
      
      popup_div.find('.thumbnail-wrapper').html("<img class=\"thumbnail-image\" src=\""+ pokemon_url + "\" alt=\"\" >");
      popup_div.find('.popup-pokemon-name-wrapper').html(pokemon_name);
      popup_div.find('.popup-pokemon-cp-wrapper').html("CP: " + pokemon_cp);
      popup_div.find('.popup-pokemon-type-wrapper').html(l.find('.species-type-wrapper').html());
      popup_div.find('.popup-pokemon-price-wrapper').html("Price: " + pokemon_price + "$");
      // console.log(this);
      // popup_div.find('#popup-message').html("");

////////////Listening pay with money form

      popup_div.find('#popup-form-pay-money').submit(function(){
        
        event.preventDefault();
        $form = $(this)
        $.ajax({
          url: $form.attr('action'),
          // url: '/',
          type: 'POST',
          data: {buyer_id: user_id, listing_id: listing_id},
          success: function(data){
            console.log(data);
            // console.log("added to trade list");
            if(data.message == "Success"){
             popup_div.find('#popup-message').html("<span style=\"color: green;\">"+ data.message +".</span>");
            }
            if(data.message == "You are out of money"){
              alert(data.message);
            }

            if(data.message == "Please Login or register to proceed."){
              alert(data.message);
              popup.close();
              window.location.replace("/login");
            }else{
              setTimeout(function(){console.log("closing popup");popup.close();}, 1000);
              location.reload();
            }
          },
          error: function(){
            // popup_div.find('#popup-message').html("<span style=\"color: red;\">Failed to add to trade list.</span>");
            // setTimeout(function(){console.log("closing popup");popup.close();}, 500);
          }
        });
      });

      popup_div.find('#popup-form-pay-pokemon').submit(function(){
        var chosen_pokemon = $('#checkout_popup .popup-check-out-pokemon-selector .listings-wishlist-user-owned');
        pokemon_id = chosen_pokemon.attr('data-pokemon-id');
        event.preventDefault();
        if (pokemon_id == null){
          alert("You need select a pokemon");
          popup.close();
        }
        $form = $(this)
        $.ajax({
          url: $form.attr('action'),
          // url: '/',
          type: 'POST',
          data: {buyer_id: user_id, listing_id: listing_id, buyer_pokemon_id: pokemon_id},
          success: function(data){
            console.log(data);
            // console.log("added to trade list");
            popup_div.find('#popup-message').html("<span style=\"color: green;\">"+ data.message +".</span>");
            
            if(data.message == "Please Login or register to proceed."){
              alert(data.message);
              popup.close();
              window.location.replace("/login");
            }else{
              setTimeout(function(){console.log("closing popup");popup.close();}, 500);
              location.reload();
            }
          },
          error: function(){
            // popup_div.find('#popup-message').html("<span style=\"color: red;\">Failed to add to trade list.</span>");
            // setTimeout(function(){console.log("closing popup");popup.close();}, 500);
          }
        });
      });
    },
    close: function() {
      // Will fire when popup is closed
    }
    // e.t.c.
  }
  });

  $('#add_to_trade_list_popup .trade-form-wish-list-item').click(function(){
    $(this.children).toggleClass("listings-wishlist-user-owned");
  });

  $('#checkout_popup .popup-check-out-pokemon-selector').click(function(){
    // chosen_pokemon_id = $(this).attr("data-pokemon-id")
    $('#checkout_popup .popup-check-out-pokemon-selector img').removeClass("listings-wishlist-user-owned");
    $(this.children).addClass("listings-wishlist-user-owned");

  });

// find URL of current page
  var url = window.location;
  // Will only work if string in href matches with location
  $('ul.nav a[href="'+ url.pathname + url.hash +'"]').parent().addClass('active');


// empty comment
  
});
