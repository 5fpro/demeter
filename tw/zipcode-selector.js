$Demeter={},$DemeterTWCityData={},$DemeterTWDistData={},$Demeter.initTWZipcodeSelector=function(e){$.ajax({url:"https://demeter.5fpro.com/tw/zipcode/cities.json",async:!1,success:function(e){$DemeterTWCityData=e}}),$.ajax({url:"https://demeter.5fpro.com/tw/zipcodes.json",async:!1,success:function(e){$DemeterTWDistData=e}});var t=function(e){var t=null;return $DemeterTWDistData.forEach(function(i){i.zipcode==e&&(t=i)}),t},i=function(e){var t=null;return $DemeterTWCityData.forEach(function(i){i.name==e&&(t=i)}),t},c=function(e){if(((e=e||$(this).val())+"").length>0){e=(e+"").substring(0,3);var i=t(e);i&&this.changeSelects(i)}else this.changeCitySelect()},n=function(e){this.changeCitySelect(e.city_name),this.changeDistSelect(e)},a=function(e){var t=this,i=this.citySelect;i.html("<option>"+this.citySelect.attr("placeholder")+"</option>"),$DemeterTWCityData.forEach(function(c){if(!t.is_exclude(c.name)){var n=c.name==e?" selected":"";i.append('<option value="'+c.name+'"'+n+">"+c.name+"</option>")}})},o=function(e){var t=this,c=this.distSelect;c.html("<option>"+c.attr("placeholder")+"</option>");var n=i(e.city_name);n&&$.get(n.zipcodes_endpoint,null,function(i){i.forEach(function(i){if(!t.is_exclude(i.zipcode)&&!t.is_exclude(i.name)){var n=i.zipcode==e.zipcode?" selected":"";c.append('<option value="'+i.name+'" data-zipcode="'+i.zipcode+'"'+n+">"+i.zipcode+" "+i.name+"</option>")}})})},s=function(e){var t=this,c=this.distSelect;c.html("<option>"+this.distSelect.attr("placeholder")+"</option>");var n=i(e);$.get(n.zipcodes_endpoint,null,function(e){e.forEach(function(e){t.is_exclude(e.zipcode)||t.is_exclude(e.name)||c.append('<option value="'+e.name+'" data-zipcode="'+e.zipcode+'">'+e.zipcode+" "+e.name+"</option>")})})},l=function(e){return this.exclude.includes(e)};e=e||".js-demeter-tw-zipcode-selector",$(e).each(function(){var e=this;e.citySelect=$($(e).data("city")),e.distSelect=$($(e).data("dist")),e.applyZipcode=c,e.changeSelects=n,e.changeCitySelect=a,e.changeDistSelect=o,e.initDistSelect=s,e.exclude=($(e).data("exclude")||"").split(","),e.is_exclude=l;var t=0;$(e).on("keypress",function(){clearTimeout(t),t=setTimeout(function(){e.applyZipcode()},500)}),e.citySelect.on("change",function(){$(e).val(""),e.initDistSelect($(this).val())}),e.distSelect.on("change",function(){var t=e.distSelect.find("option[value="+$(this).val()+"]").last().data("zipcode");t&&$(e).val(t)}),$(e).trigger("keypress")})},$(function(){$Demeter.initTWZipcodeSelector()});