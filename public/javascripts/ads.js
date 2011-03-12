var show_cities_for_region = function() {
  $(".region_div").each(function() {
    $(this).addClass('invisible');
    $(this).find('select').attr('name', '');
  });

  if($(this).val() == '')
    return;

  var selector = "#region-" + $(this).val();

  $(selector).removeClass('invisible');
  $(selector).find('select').attr('name', 'ad[city_id]');
};

$(document).ready(function() {
  $(".regions_select_box").change(show_cities_for_region);
  $(".regions_select_box").trigger('change');
});
