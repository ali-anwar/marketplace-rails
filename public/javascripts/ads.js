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

var show_cities_for_search_region = function() {
  var option   = $(this).find("option:selected");
  var selector = "#region-" + option.attr('crc');
  var new_html = $(selector).html();

  $("#cities-container").html(new_html);
  $("#search_city_region_text").val(option.text());
};

var show_details_for_category_name = function() {
  var select_option = $(this).find("option:selected");
  var v = select_option.attr('crc');
  var map = {
    '1123203261':'detail-basic-estates',
    '2457596157':'detail-basic-estates',
    '941107038':'detail-basic-estates',
    '2458100605':'detail-basic-estates',
    '986302160':'detail-basic-estates',
    '2005487667':'detail-basic-estates',
    '905294378':'detail-basic-vehicles',
    '1253994930':'detail-basic-vehicles',
    '4240109520':'detail-basic-vehicles',
    '3114757579':'detail-other-vehicles',
    '3745483444': 'detail-empty',
    '33920175': 'detail-empty',
  };
  var selector = '#' + (map[v] || 'detail-defaults');
  var new_html = $(selector).html();
  var old_html = $("#details-container").html();

  if(old_html != new_html) {
    $("#details-container").slideUp().html(new_html).slideDown();
  }
  
  if(select_option.attr('parent')) {
    $("#search_category_parent_name").val('');
  } else {
    $("#search_category_parent_name").val(v);
  
  }
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
  var old_html = $("#details-container").html();

  if(old_html != new_html)
    $("#details-container").slideUp().html(new_html).slideDown();
};

var add_more_image = function() {
  var div = $('#upload-image-container').find('div').clone();
  div.find('input').attr('name', 'ad[upload_attributes][new][' + ++upload_images_count + '][photo]')

  $("#uploads").append(div);

  return false;
};

var check_keyword = function() {
  var k = $("#search_keyword");
  if (k.val() == k.attr('title'))
    k.val('');

  return true;
};

$(document).ready(function() {
  $(".regions_select_box").change(show_cities_for_region).trigger('change');

  $("#ad_category_id").change(show_details_for_category).trigger('change');
  $("#search_category_name").change(show_details_for_category_name).trigger('change');
  $("#search_city_region").change(show_cities_for_search_region).trigger('change');

  $(".add-more-image").click(add_more_image);

  $(".watermarked").each(function() {
    $(this).Watermark($(this).attr('title'));
  });

});

