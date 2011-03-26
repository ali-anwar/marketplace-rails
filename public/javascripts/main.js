function highlight_map (region, offset, transparent_start, out, coord) {
  var LinkItem = document.getElementById("area_" + region);
  var HighlightItem = document.getElementById("area_highlight");
  var base_off = transparent_start ? offset : 0;

  if (!out) {
    var shift = base_off + (-offset * region);
    if (coord) 
      shift = base_off + (-offset * coord);
    LinkItem.style.textDecoration = "underline";
    HighlightItem.style.backgroundPosition = shift + 'px 0px';
  } else {
    LinkItem.style.textDecoration = "none";
    HighlightItem.style.backgroundPosition = base_off + "px 0px";
  }

  return true;
}

