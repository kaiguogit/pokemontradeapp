$(document).ready(function() {

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $(".wish_list_button").click(function() {

    $("#pokemon_to_wish").val($(this).data("id"));

    $('form[name="wish_list_form"]').submit();

  });


  
  //update pokedex by search box 
  var name_input = $('#search-pokemon');
  var type_input = $('#type-pokemon');
  //var name_input = document.getElementById('search-pokemon');
  name_input = $(name_input);

  name_input.keyup(function(){filter_pokemon()});
  type_input.chosen().change(function(){filter_pokemon()});

  

var filter_pokemon = function(){
      var name_filter = name_input.val().toUpperCase();
      var type_filter = type_input.val();
      var lis = $('.col-pokedex');
      lis.each(function(i,l){
      var $l = $(l)
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

});

jQuery(document).ready(function($) {
  $('.popup-ajax').magnificPopup({
  type:'ajax'
  // midClick: true,
  // ajax: {
  //   settings:{
  //     method: "GET",
  //     url: "/pokemon/add/1",
  //     success: function(){
  //       console.log("success!")
  //     }
  //   }
  // }
});
});
