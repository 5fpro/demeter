$Demeter={},$DemeterTWCityData={},$DemeterTWDistData={},$Demeter.initTWZipcodeSelector=function(e){$.ajax({url:"https://demeter.5fpro.com/tw/zipcode/cities.json",async:!1,success:function(e){$DemeterTWCityData=e}}),$.ajax({url:"https://demeter.5fpro.com/tw/zipcodes.json",async:!1,success:function(e){$DemeterTWDistData=e}});var t=function(e,t){var i=null,n=null;return $DemeterTWDistData.forEach(function(a){a.zipcode==e&&(t?t==a.name?i=a:n=a:i=a)}),i=i||n},i=function(e){var t=null;return $DemeterTWCityData.forEach(function(i){i.name==e&&(t=i)}),t},n=function(e){e=e||$(this).val();var i=$(this).val()?$(this).data("selected-dist"):null;if((e+"").length>0){e=(e+"").substring(0,3);var n=t(e,i);n?this.changeSelects(n):this.changeCitySelect()}else this.changeCitySelect()},a=function(e){this.changeCitySelect(e.city_name),this.changeDistSelect(e)},c=function(e){var t=this,i=this.citySelect;i.html('<option value="">'+this.citySelect.attr("placeholder")+"</option>"),$DemeterTWCityData.forEach(function(n){if(!t.is_exclude(n.name)){var a=n.name==e||n.name==i.data("selected")||n.name==$(t).data("selected-city")?" selected":"";i.append('<option value="'+n.name+'"'+a+">"+n.name+"</option>")}})},o=function(e){var t=this,n=this.distSelect;n.html('<option value="">'+n.attr("placeholder")+"</option>");var a=i(e.city_name);a&&$.get(a.zipcodes_endpoint,null,function(i){i.forEach(function(i){if(!t.is_exclude(i.zipcode)&&!t.is_exclude(i.name)){var a=i.zipcode==e.zipcode&&i.name==e.name?" selected":"";n.append('<option value="'+i.name+'" data-zipcode="'+i.zipcode+'"'+a+">"+i.zipcode+" "+i.name+"</option>")}})})},l=function(e){var t=this,n=this.distSelect;n.html('<option value="">'+this.distSelect.attr("placeholder")+"</option>");var a=i(e);$.get(a.zipcodes_endpoint,null,function(e){e.forEach(function(e){t.is_exclude(e.zipcode)||t.is_exclude(e.name)||n.append('<option value="'+e.name+'" data-zipcode="'+e.zipcode+'">'+e.zipcode+" "+e.name+"</option>")})})},s=function(e){return this.exclude.includes(e)};e=e||".js-demeter-tw-zipcode-selector",$(e).each(function(){var e=this;$(e).attr("pattern","\\d+").attr("type","tel").attr("maxlength","3").attr("minlength","3"),e.citySelect=$($(e).data("city")),e.distSelect=$($(e).data("dist")),e.applyZipcode=n,e.changeSelects=a,e.changeCitySelect=c,e.changeDistSelect=o,e.initDistSelect=l,e.exclude=($(e).data("exclude")||"").split(","),e.is_exclude=s;var t=0;$(e).on("keyup",function(){this.reportValidity&&this.reportValidity()}),$(e).on("keypress",function(i){if(i.keyCode<48||i.keyCode>57)return this.reportValidity&&this.reportValidity(),!1;clearTimeout(t),t=setTimeout(function(){e.applyZipcode()},500)}),e.citySelect.on("change",function(){$(e).val(""),e.initDistSelect($(this).val())}),e.distSelect.on("change",function(){var t=e.distSelect.find("option[value="+$(this).val()+"]").last().data("zipcode");t&&$(e).val(t)}),$(e).trigger("keypress")})},$(function(){$Demeter.initTWZipcodeSelector()});