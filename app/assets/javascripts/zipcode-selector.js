$Demeter = {};
$DemeterTWCityData = {};
$DemeterTWDistData = {};
$Demeter.initTWZipcodeSelector = function(trigger_selector) {
  $.ajax({ url: 'https://demeter.5fpro.com/tw/zipcode/cities.json', async: false, success: function(data) {
    $DemeterTWCityData = data;
  }});
  $.ajax({ url: 'https://demeter.5fpro.com/tw/zipcodes.json', async: false, success: function(data) {
    $DemeterTWDistData = data;
  }});
  var findDist = function(zipcode, selected_dist) {
    var res = null;
    var tmpRes = null;
    $DemeterTWDistData.forEach(function(dist) {
      if(dist.zipcode == zipcode) {
        if(selected_dist) {
          if(selected_dist == dist.name) {
            res = dist;
          } else {
            tmpRes = dist
          }
        } else {
          res = dist;
        }
      }
    })
    res = res || tmpRes;
    return res;
  }
  var findCity = function(city_name) {
    var res = null
    $DemeterTWCityData.forEach(function(city) {
      if(city.name == city_name) {
        res = city;
      }
    })
    return res;
  }
  var applyZipcode = function(zipcode) {
    zipcode = zipcode || $(this).val();
    var dist_value = $(this).val() ? $(this).data('selected-dist') : null;
    if((zipcode + '').length > 0) {
      zipcode = (zipcode + '').substring(0, 3)
      var dist = findDist(zipcode, dist_value);
      if(dist) {
        this.changeSelects(dist);
      } else {
        this.changeCitySelect();
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
    citySelect.html('<option value="">' + this.citySelect.attr('placeholder') +'</option>');
    $DemeterTWCityData.forEach(function(city) {
      if(zipcodeInput.is_exclude(city.name)) { return; }
      var selected = city.name == city_name ? ' selected' : ''
      citySelect.append('<option value="' + city.name + '"' + selected + '>' + city.name + '</option>')
    });
  }
  var changeDistSelect = function(selected_dist) {
    var zipcodeInput = this;
    var distSelect = this.distSelect;
    distSelect.html('<option value="">' + distSelect.attr('placeholder') +'</option>');
    var city = findCity(selected_dist.city_name);
    if(city) {
      $.get(city.zipcodes_endpoint, null, function(dists) {
        dists.forEach(function(dist) {
          if(zipcodeInput.is_exclude(dist.zipcode) || zipcodeInput.is_exclude(dist.name)) { return; }
          var selected = (dist.zipcode == selected_dist.zipcode && dist.name == selected_dist.name) ? ' selected' : ''
          distSelect.append('<option value="' + dist.name + '" data-zipcode="' + dist.zipcode + '"' + selected + '>' + dist.zipcode + ' ' + dist.name + '</option>')
        })
      })
    }
  }
  var initDistSelect = function(city_name) {
    var zipcodeInput = this;
    var distSelect = this.distSelect;
    distSelect.html('<option value="">' + this.distSelect.attr('placeholder') +'</option>');
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
  trigger_selector = trigger_selector || '.js-demeter-tw-zipcode-selector';
  $(trigger_selector).each(function() {
    var zipcode = this;
    $(zipcode).attr('pattern', '\\d+').attr('type', 'tel').attr('maxlength', '3').attr('minlength', '3');
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
    $(zipcode).on('keyup', function() {
      if(this.reportValidity) {
        this.reportValidity();
      }
    });
    $(zipcode).on('keypress', function(event) {
      if(event.keyCode < 48 || event.keyCode > 57) {
        if(this.reportValidity) { this.reportValidity(); }
        return false;
      }
      clearTimeout(timeoutId);
      timeoutId = setTimeout(function() {
        zipcode.applyZipcode();
      }, 500)
    });
    zipcode.citySelect.on('change', function() {
      $(zipcode).val('');
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
  $Demeter.initTWZipcodeSelector();
})
