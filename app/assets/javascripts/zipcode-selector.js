$Demeter = {};
$DemeterTWCityData = {};
$DemeterTWDistData = {};
$Demeter.fetchData = function() {
  var promises = [];
  if (Object.keys($DemeterTWCityData).length == 0) {
    promises.push(
      fetch("https://demeter.5fpro.com/tw/zipcode/cities.json")
        .then(function(res) { return res.json(); })
        .then(function(data) { $DemeterTWCityData = data; })
    );
  }
  if (Object.keys($DemeterTWDistData).length == 0) {
    promises.push(
      fetch("https://demeter.5fpro.com/tw/zipcodes.json")
        .then(function(res) { return res.json(); })
        .then(function(data) { $DemeterTWDistData = data; })
    );
  }
  return Promise.all(promises);
};
$Demeter.initTWZipcodeSelector = function(triggerSelector) {
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
  var findSelectedCityName = function(zipcode) {
    var citySelected = zipcode.citySelect ? zipcode.citySelect.dataset.selected : null;
    return (zipcode.dataset.selectedCity || citySelected || '').replace('台', '臺');
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
    zipcode = zipcode || this.value;
    var dist_value = this.value ? this.dataset.selectedDist : null;
    if (!dist_value && this.dataset.selectedDist) {
      dist_value = {
        name: this.dataset.selectedDist,
      }
    }
    if((zipcode + '').length > 0) {
      zipcode = (zipcode + '').substring(0, 3)
      var dist = findDist(zipcode, dist_value);
      if(dist) {
        this.changeSelects(dist);
      } else {
        this.changeCitySelect();
        this.changeDistSelect();
      }
    } else {
      this.changeCitySelect();
      this.changeDistSelect(dist_value);
    }
  }
  var changeSelects = function(dist) {
    this.changeCitySelect(dist.city_name);
    this.changeDistSelect(dist);
  }
  var changeCitySelect = function(city_name) {
    var zipcodeInput = this;
    var citySelect = this.citySelect;
    citySelect.innerHTML = '<option value="">' + (citySelect.getAttribute('placeholder') || '') + '</option>';
    $DemeterTWCityData.forEach(function(city) {
      if(zipcodeInput.is_exclude(city.name)) { return; }
      var selected = (city.name == city_name || city.name == findSelectedCityName(zipcodeInput)) ? ' selected' : ''
      citySelect.insertAdjacentHTML('beforeend', '<option value="' + city.name + '"' + selected + '>' + city.name + '</option>')
    });
  }
  var changeDistSelect = function(selected_dist) {
    selected_dist = selected_dist || {};
    var zipcodeInput = this;
    var distSelect = this.distSelect;
    distSelect.innerHTML = '<option value="">' + (distSelect.getAttribute('placeholder') || '') + '</option>';
    var city = findCity(selected_dist.city_name || findSelectedCityName(zipcodeInput));
    if(city) {
      fetch(city.zipcodes_endpoint).then(function(res) { return res.json(); }).then(function(dists) {
        dists.forEach(function(dist) {
          if(zipcodeInput.is_exclude(dist.zipcode) || zipcodeInput.is_exclude(dist.name)) { return; }
          var selected = (dist.zipcode == selected_dist.zipcode && dist.name == selected_dist.name) ? ' selected' : ''
          if (selected == '' && dist.name == selected_dist.name) { selected = ' selected' }
          distSelect.insertAdjacentHTML('beforeend', '<option value="' + dist.name + '" data-zipcode="' + dist.zipcode + '"' + selected + '>' + dist.zipcode + ' ' + dist.name + '</option>')
        })
      })
    }
  }
  var initDistSelect = function(city_name) {
    var zipcodeInput = this;
    var distSelect = this.distSelect;
    distSelect.innerHTML = '<option value="">' + (distSelect.getAttribute('placeholder') || '') + '</option>';
    var city = findCity(city_name);
    fetch(city.zipcodes_endpoint).then(function(res) { return res.json(); }).then(function(dists) {
      dists.forEach(function(dist) {
        if(zipcodeInput.is_exclude(dist.zipcode) || zipcodeInput.is_exclude(dist.name)) { return; }
        distSelect.insertAdjacentHTML('beforeend', '<option value="' + dist.name + '" data-zipcode="' + dist.zipcode + '">' + dist.zipcode + ' ' + dist.name + '</option>')
      })
    })
  }

  var is_exclude = function(value) {
    return this.exclude.includes(value);
  }
  triggerSelector = triggerSelector || ".js-demeter-tw-zipcode-selector";
  var elements = document.querySelectorAll(triggerSelector);
  if (elements.length == 0) { return; }
  $Demeter.fetchData().then(function() {
    elements.forEach(function(zipcode) {
      zipcode.setAttribute('pattern', '\\d+');
      zipcode.setAttribute('type', 'tel');
      zipcode.setAttribute('maxlength', '6');
      zipcode.setAttribute('minlength', '3');
      zipcode.setAttribute('inputmode', 'numeric');
      zipcode.citySelect = document.querySelector(zipcode.dataset.city);
      zipcode.distSelect = document.querySelector(zipcode.dataset.dist);
      zipcode.applyZipcode = applyZipcode;
      zipcode.changeSelects = changeSelects;
      zipcode.changeCitySelect = changeCitySelect;
      zipcode.changeDistSelect = changeDistSelect;
      zipcode.initDistSelect = initDistSelect;
      zipcode.exclude = (zipcode.dataset.exclude || '').split(',');
      zipcode.is_exclude = is_exclude;
      var timeoutId = 0;
      zipcode.addEventListener("keyup", function(event) {
        if (!event.key.match(/[0-9]/)) {
          if (this.reportValidity) {
            this.reportValidity();
            return false;
          }
          return false;
        } else {
          if (this.reportValidity) {
            this.reportValidity();
          }
        }
        clearTimeout(timeoutId);
        timeoutId = setTimeout(function() {
          zipcode.applyZipcode();
        }, 500);
      });
      zipcode.citySelect.addEventListener("change", function() {
        zipcode.value = "";
        zipcode.initDistSelect(this.value);
      });
      zipcode.distSelect.addEventListener("change", function() {
        var selectedValue = this.value;
        var value = null;
        zipcode.distSelect.querySelectorAll('option').forEach(function(option) {
          if (option.value == selectedValue && option.dataset.zipcode) {
            value = option.dataset.zipcode;
          }
        });
        if (value) {
          zipcode.value = value;
        }
      });
      zipcode.applyZipcode();
    });
  });
};

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', function() {
    $Demeter.initTWZipcodeSelector();
  });
} else {
  $Demeter.initTWZipcodeSelector();
}
