var upload_images_count = 0;

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

var show_details_for_category = function() {
  var v = $(this).val();
  var map = {
    '': 'detail-defaults',
    '1':'detail-basic-estates',
    '2':'detail-basic-estates',
    '3':'detail-basic-estates',
    '4':'detail-basic-estates',
    '5':'detail-defaults',
    '6':'detail-basic-estates',
    '7':'detail-defaults',
    '8':'detail-basic-vehicles',
    '9':'detail-basic-vehicles',
    '10':'detail-defaults',
    '11':'detail-basic-vehicles',
    '12':'detail-other-vehicles',
    '13': 'detail-defaults',
    '14': 'detail-defaults',
    '15': 'detail-defaults',
    '16': 'detail-defaults',
    '17': 'detail-defaults',
    '18': 'detail-defaults',
    '19': 'detail-defaults',
    '20': 'detail-defaults',
    '21': 'detail-defaults',
    '22': 'detail-defaults',
    '23': 'detail-defaults',
    '24': 'detail-defaults',
    '25': 'detail-defaults',
    '26': 'detail-defaults',
    '27': 'detail-defaults',
    '28': 'detail-empty',
    '29': 'detail-empty',
    '30': 'detail-defaults',
    '31': 'detail-defaults',
    '32': 'detail-defaults',
    '33': 'detail-defaults',
  };
  var selector = '#' + map[v];
  var new_html = $(selector).html();
  $("#details-container").slideUp().html(new_html).slideDown();
};

var add_more_image = function() {
  var span = $('#upload-image-container').find('span').clone();
  span.find('input').attr('name', 'ad[upload_attributes][new][' + ++upload_images_count + '][photo]')

  $("#uploads").append(span);

  return false;
};

$(document).ready(function() {
  $(".regions_select_box").change(show_cities_for_region);
  $(".regions_select_box").trigger('change');

  $("#ad_category_id").change(show_details_for_category);
  $("#ad_category_id").trigger('change');

  $(".add-more-image").click(add_more_image);
});
