$cityData = {};
$distData = {};
$Gaia = {};
$Gaia.init_zipcode_selector = function() {
  $.ajax({ url: 'https://demeter.5fpro.com/tw/zipcode/cities.json', async: false, success: function(data) {
    $cityData = data;
  }});
  $.ajax({ url: 'https://demeter.5fpro.com/tw/zipcodes.json', async: false, success: function(data) {
    $distData = data;
  }});
  var findDist = function(zipcode) {
    var res = null
    $distData.forEach(function(dist) {
      if(dist.zipcode == zipcode) {
        res = dist;
      }
    })
    return res;
  }
  var findCity = function(city_name) {
    var res = null
    $cityData.forEach(function(city) {
      if(city.name == city_name) {
        res = city;
      }
    })
    return res;
  }
  var applyZipcode = function(zipcode) {
    zipcode = zipcode || $(this).val();
    if((zipcode + '').length > 0) {
      var dist = findDist(zipcode);
      if(dist) {
        this.changeSelects(dist);
      }
    } else {
      this.changeCitySelect();
    }
  }
  var changeSelects = function(dist) {
    this.changeCitySelect(dist.city_name);
    this.changeDistSelect(dist);
  }
  var changeCitySelect = function(city_name) {
    var zipcodeInput = this;
    var citySelect = this.citySelect;
    citySelect.html('<option>' + this.citySelect.attr('placeholder') +'</option>');
    $cityData.forEach(function(city) {
      if(zipcodeInput.is_exclude(city.name)) { return; }
      var selected = city.name == city_name ? ' selected' : ''
      citySelect.append('<option value="' + city.name + '"' + selected + '>' + city.name + '</option>')
    });
  }
  var changeDistSelect = function(selected_dist) {
    var zipcodeInput = this;
    var distSelect = this.distSelect;
    distSelect.html('<option>' + distSelect.attr('placeholder') +'</option>');
    var city = findCity(selected_dist.city_name);
    if(city) {
      $.get(city.zipcodes_endpoint, null, function(dists) {
        dists.forEach(function(dist) {
          if(zipcodeInput.is_exclude(dist.zipcode) || zipcodeInput.is_exclude(dist.name)) { return; }
          var selected = dist.zipcode == selected_dist.zipcode ? ' selected' : ''
          distSelect.append('<option value="' + dist.name + '" data-zipcode="' + dist.zipcode + '"' + selected + '>' + dist.zipcode + ' ' + dist.name + '</option>')
        })
      })
    }
  }
  var initDistSelect = function(city_name) {
    var zipcodeInput = this;
    var distSelect = this.distSelect;
    distSelect.html('<option>' + this.distSelect.attr('placeholder') +'</option>');
    var city = findCity(city_name);
    $.get(city.zipcodes_endpoint, null, function(dists) {
      dists.forEach(function(dist) {
        if(zipcodeInput.is_exclude(dist.zipcode) || zipcodeInput.is_exclude(dist.name)) { return; }
        distSelect.append('<option value="' + dist.name + '" data-zipcode="' + dist.zipcode + '">' + dist.zipcode + ' ' + dist.name + '</option>')
      })
    })
  }

  var is_exclude = function(value) {
    return this.exclude.includes(value);
  }
  $('.js-gaia-zipcode').each(function() {
    var zipcode = this;
    zipcode.citySelect = $($(zipcode).data('city'));
    zipcode.distSelect = $($(zipcode).data('dist'));
    zipcode.applyZipcode = applyZipcode;
    zipcode.changeSelects = changeSelects;
    zipcode.changeCitySelect = changeCitySelect;
    zipcode.changeDistSelect = changeDistSelect;
    zipcode.initDistSelect = initDistSelect;
    zipcode.exclude = ($(zipcode).data('exclude') || '').split(',');
    zipcode.is_exclude = is_exclude;
    var timeoutId = 0;
    $(zipcode).on('keypress', function() {
      clearTimeout(timeoutId);
      timeoutId = setTimeout(function() {
        zipcode.applyZipcode();
      }, 500)
    })
    zipcode.citySelect.on('change', function() {
      zipcode.initDistSelect($(this).val());
    });
    zipcode.distSelect.on('change', function() {
      var value = zipcode.distSelect.find('option[value=' + $(this).val() +']').last().data('zipcode')
      if(value) {
        $(zipcode).val(value);
      }
    });
    $(zipcode).trigger('keypress')
  });
}

$(function() {
  $Gaia.init_zipcode_selector();
})
