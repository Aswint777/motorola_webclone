Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
		
		log:function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log(msg.name + ': ' + msg.message);
					} else {
						console.log.apply(console, arguments);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_error: function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
					} else {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_success: function(msg) {
			if (usi_commons.debug) {
				try {
					console.log('%c USI Success:', usi_commons.log_styles.success, msg);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		dir:function(obj) {
			if (usi_commons.debug) {
				try {
					console.dir(obj);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://app.upsellit.com",
		cdn: "https://www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			try {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null) return "";
				else return results[1];
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_script:function(source, callback, nocache) {
			try {
				if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source; //upgrade non-secure requests
				var docHead = document.getElementsByTagName("head")[0];
				if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				var usi_appender = "";
				if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations.jsp") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
					usi_appender = (source.indexOf("?")==-1?"?":"&");
					if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
					usi_appender += "si=" + usi_commons.get_sess();
				}
				newScript.src = source + usi_appender;
				if (typeof callback == "function") {
					newScript.onload = function() {
						try {
							callback();
						} catch (e) {
							usi_commons.report_error(e);
						}
					};
				}
				docHead.appendChild(newScript);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_display:function(usiQS, usiSiteID, usiKey, callback) {
			try {
				usiKey = usiKey || "";
				var source = usi_commons.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			try {
				if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
					usiKey = usiKey || "";
					var usi_append = "";
					if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
					else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
					if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
					var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
					if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
					usi_commons.last_view = usiSiteID+"_"+usiKey;
					if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
					usi_commons.load_script(source, callback);
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		remove_loads:function() {
			try {
				if (document.getElementById("usi_obj") != null) {
					document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
				}
				if (typeof(usi_commons.usi_loads) !== "undefined") {
					for (var i in usi_commons.usi_loads) {
						if (document.getElementById("usi_"+i) != null) {
							document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
						}
					}
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			try {
				if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
				usiKey = usiKey || "";
				var usi_append = "";
				if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				usi_commons.load_script(source, callback);
				if (typeof(usi_commons.usi_loads) === "undefined") {
					usi_commons.usi_loads = {};
				}
				usi_commons.usi_loads[usiSiteID] = usiSiteID;
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			try {
				if (typeof(usi_commons.last_precapture_siteID) !== "undefined" && usi_commons.last_precapture_siteID == usiSiteID) return;
				usi_commons.last_precapture_siteID = usiSiteID;
				var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_mail:function(qs, siteID, callback) {
			try {
				var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_products:function(options) {
			try {
				if (!options.siteID || !options.pid) return;
				var queryStr = "";
				var params = ['siteID', 'association_siteID', 'pid', 'less_expensive', 'rows', 'days_back', 'force_exact', 'match', 'nomatch', 'name_from', 'image_from', 'price_from', 'url_from', 'extra_from', 'custom_callback', 'allow_dupe_names', 'expire_seconds', 'name'];
				params.forEach(function(name, index){
					if (options[name]) {
						queryStr += (index == 0 ? "?" : "&") + name + '=' + options[name];
					}
				});
				if (options.filters) {
					queryStr += "&filters=" + encodeURIComponent(options.filters.join("&"));
				}
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations_filter.jsp' + queryStr, function(){
					if (typeof options.callback === 'function') {
						options.callback();
					}
				});
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
					if (info.extra) queryString += info.extra + "|";
					var filetype = real_time ? "jsp" : "js";
					usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				usi_commons.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		report_error_no_console:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			try {
				if (typeof usi_cookies === 'undefined') {
					usi_commons.log_error('usi_cookies is not defined');
					return;
				}
				expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
				if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
				var value = null;
				var qsValue = usi_commons.gup(name);
				if (qsValue !== '') {
					value = qsValue;
					usi_cookies.set(name, value, expireSeconds, forceCookie);
				} else {
					value = usi_cookies.get(name);
				}
				return (value || '');
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		get_sess: function() {
			var usi_si = null;
			if (typeof(usi_cookies) === "undefined") return "";
			try {
				if (usi_cookies.get('usi_si') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_si', usi_si, 24*60*60);
					return usi_si;
				}
				if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
				usi_cookies.set('usi_si', usi_si, 24*60*60);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_si;
		},
		get_id: function(usi_append) {
			if (!usi_append) usi_append = "";
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
				usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		load_session_data: function(extended) {
			try {
				if (usi_cookies.get_json("usi_session_data") == null) {
					usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
				} else {
					usi_app.session_data = usi_cookies.get_json("usi_session_data");
					if (typeof(usi_app.session_data_callback) !== "undefined") {
						usi_app.session_data_callback();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	};
	setTimeout(function() {
		try {
			if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
			if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
				usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
			}
		} catch(err) {
			usi_commons.report_error(err);
		}
	}, 1000);
}

if (typeof usi_app === 'undefined') {
	try {
		if("undefined"==typeof usi_cookies&&(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,o,i){try{var n=-1;if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n=t.getTime()}var r=window.top||window,s=0;null!=o&&-1!=o.indexOf("=")&&(o=o.replace(new RegExp("=","g"),"USIEQLS")),null!=o&&-1!=o.indexOf(";")&&(o=o.replace(new RegExp(";","g"),"USIPRNS"));for(var a=r.name.split(";"),u="",c=0;c<a.length;c++){var l=a[c].split("=");3==l.length?(l[0]==e&&(l[1]=o,l[2]=n,s=1),null!=l[1]&&"null"!=l[1]&&(u+=l[0]+"="+l[1]+"="+l[2]+";")):""!=a[c]&&(u+=a[c]+";")}0==s&&(u+=e+"="+o+"="+n+";"),r.name=u}catch(e){}},flush_window_name:function(e){try{for(var o=window.top||window,i=o.name.split(";"),n="",t=0;t<i.length;t++){var r=i[t].split("=");3==r.length&&(0==r[0].indexOf(e)||(n+=i[t]+";"))}o.name=n}catch(e){}},get_from_window_name:function(e){try{for(var o,i=(window.top||window).name.split(";"),n=0;n<i.length;n++){var t=i[n].split("=");if(3==t.length){if(t[0]==e&&(-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),!("-1"!=t[2]&&usi_cookies.datediff(t[2])<0)))return[o,t[2]]}else if(2==t.length&&t[0]==e)return-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),[o,(new Date).getTime()+6048e5]}}catch(e){}return null},datediff:function(e){return e-(new Date).getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),o=e[e.length-1];if("com"==o||"net"==o||"org"==o||"us"==o||"co"==o||"ca"==o)return e[e.length-2]+"."+e[e.length-1]}catch(e){}return document.domain},create_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(o)+n+"; path=/;domain="+s+"; "+r}},create_nonencoded_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+o+n+"; path=/;domain="+s+"; "+r}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var o=e+"=",i=[];try{i=document.cookie.split(";")}catch(e){}for(var n=0;n<i.length;n++){for(var t=i[n];" "==t.charAt(0);)t=t.substring(1,t.length);if(0==t.indexOf(o))return decodeURIComponent(t.substring(o.length,t.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(e){}},get_ls:function(e){try{var o=localStorage.getItem(e);if(null!=o){if(0==o.indexOf("{")&&-1!=o.indexOf("usi_expires")){var i=JSON.parse(o);if((new Date).getTime()>i.usi_expires)return localStorage.removeItem(e),null;o=i.value}return decodeURIComponent(o)}}catch(e){}return null},get:function(e){var o=usi_cookies.read_cookie(e);if(null!=o)return o;try{if(null!=localStorage&&null!=(o=usi_cookies.get_ls(e)))return o;if(null!=sessionStorage&&null!=(o=sessionStorage.getItem(e)))return decodeURIComponent(o)}catch(e){}var i=usi_cookies.get_from_window_name(e);if(null!=i&&i.length>1)try{o=decodeURIComponent(i[0])}catch(e){return i[0]}return o},get_json:function(e){var o=null,i=usi_cookies.get(e);if(null==i)return null;try{o=JSON.parse(i)}catch(e){i=i.replace(/\\"/g,'"');try{o=JSON.parse(JSON.parse(i))}catch(e){try{o=JSON.parse(i)}catch(e){}}}return o},search_cookies:function(e){e=e||"";var o=[];return document.cookie.split(";").forEach((function(i){var n=i.split("=")[0].trim();""!==e&&0!==n.indexOf(e)||o.push(n)})),o},set:function(e,o,i,n){"undefined"!=typeof usi_nevercookie&&(n=!1),void 0===i&&(i=-1);try{o=o.replace(/(\r\n|\n|\r)/gm,"")}catch(e){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",o+"",i);try{if(i>0&&null!=localStorage){var t={value:o,usi_expires:(new Date).getTime()+1e3*i};localStorage.setItem(e,JSON.stringify(t))}else null!=sessionStorage&&sessionStorage.setItem(e,o)}catch(e){}if(n||null==o){if(null!=o){if(null==usi_cookies.read_cookie(e))if(!n)if(usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count)return void usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);if(o.length>usi_cookies.max_cookie_length)return void usi_cookies.report_error('Cookie "'+e+'" truncated ('+o.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length)}usi_cookies.create_cookie(e,o,i)}},set_json:function(e,o,i,n){var t=JSON.stringify(o).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,t,i,n)},flush:function(e){e=e||"usi_";var o,i,n,t=document.cookie.split(";");for(o=0;o<t.length;o++)0==(i=t[o]).trim().toLowerCase().indexOf(e)&&(n=i.trim().split("=")[0],usi_cookies.del(n));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&localStorage.removeItem(r);if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&sessionStorage.removeItem(r)}catch(e){}},print:function(){for(var e=document.cookie.split(";"),o="",i=0;i<e.length;i++){var n=e[i];0==n.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(n.trim())+" (cookie)"),o+=","+n.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var t in localStorage)0==t.indexOf("usi_")&&"string"==typeof localStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+usi_cookies.get_ls(t)+" (localStorage)"),o+=","+t+",");if(null!=sessionStorage)for(var t in sessionStorage)0==t.indexOf("usi_")&&"string"==typeof sessionStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+sessionStorage[t]+" (sessionStorage)"),o+=","+t+",")}catch(e){}for(var r=(window.top||window).name.split(";"),s=0;s<r.length;s++){var a=r[s].split("=");if(3==a.length&&0==a[0].indexOf("usi_")&&-1==o.indexOf(","+a[0]+",")){var u=a[1];-1!=u.indexOf("USIEQLS")&&(u=u.replace(new RegExp("USIEQLS","g"),"=")),-1!=u.indexOf("USIPRNS")&&(u=u.replace(new RegExp("USIPRNS","g"),";")),console.log(a[0]+"="+u+" (window.name)"),o+=","+n.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,o;for(e=0;e<arguments.length;e++)if(""===(o=usi_cookies.get(arguments[e]))||null===o||"null"===o||"undefined"===o)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie))try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&(usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?usi_email_id_fix="+encodeURIComponent(usi_cookies.get_from_window_name("usi_email_id")[0])),usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-(new Date).getTime())/1e3,!0)),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}
"undefined"==typeof usi_dom&&(usi_dom={},usi_dom.get_elements=function(e,t){return t=t||document,Array.prototype.slice.call(t.querySelectorAll(e))},usi_dom.count_elements=function(e,t){return t=t||document,usi_dom.get_elements(e,t).length},usi_dom.get_nth_element=function(e,t,n){var o=null;n=n||document;var r=usi_dom.get_elements(t,n);return r.length>=e&&(o=r[e-1]),o},usi_dom.get_first_element=function(e,t){if(""===(e||""))return null;if(t=t||document,"[object Array]"===Object.prototype.toString.call(e)){for(var n=null,o=0;o<e.length;o++){var r=e[o];if(null!=(n=usi_dom.get_first_element(r,t)))break}return n}return t.querySelector(e)},usi_dom.get_element_text_no_children=function(e,t){var n="";if(null==t&&(t=!1),null!=(e=e||document)&&null!=e.childNodes)for(var o=0;o<e.childNodes.length;++o)3===e.childNodes[o].nodeType&&(n+=e.childNodes[o].textContent);return!0===t&&(n=usi_dom.clean_string(n)),n.trim()},usi_dom.clean_string=function(e){if("string"==typeof e){return(e=(e=(e=(e=(e=(e=(e=e.replace(/[\u2010-\u2015\u2043]/g,"-")).replace(/[\u2018-\u201B]/g,"'")).replace(/[\u201C-\u201F]/g,'"')).replace(/\u2024/g,".")).replace(/\u2025/g,"..")).replace(/\u2026/g,"...")).replace(/\u2044/g,"/")).replace(/[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g,"").trim()}},usi_dom.encode=function(e){if("string"==typeof e){var t=encodeURIComponent(e);return t=t.replace(/[-_.!~*'()]/g,function(e){return"%"+e.charCodeAt(0).toString(16).toUpperCase()})}},usi_dom.get_closest=function(e,t){for(e=e||document,"function"!=typeof Element.prototype.matches&&(Element.prototype.matches=Element.prototype.matchesSelector||Element.prototype.mozMatchesSelector||Element.prototype.msMatchesSelector||Element.prototype.oMatchesSelector||Element.prototype.webkitMatchesSelector||function(e){for(var t=(this.document||this.ownerDocument).querySelectorAll(e),n=t.length;--n>=0&&t.item(n)!==this;);return n>-1});null!=e&&e!==document;e=e.parentNode)if(e.matches(t))return e;return null},usi_dom.get_classes=function(e){var t=[];return null!=e&&null!=e.classList&&(t=Array.prototype.slice.call(e.classList)),t},usi_dom.add_class=function(e,t){if(null!=e){var n=usi_dom.get_classes(e);-1===n.indexOf(t)&&(n.push(t),e.className=n.join(" "))}},usi_dom.string_to_decimal=function(e){var t=null;if("string"==typeof e)try{var n=parseFloat(e.replace(/[^0-9\.-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.string_to_integer=function(e){var t=null;if("string"==typeof e)try{var n=parseInt(e.replace(/[^0-9-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.get_currency_string_from_content=function(e){if("string"!=typeof e)return"";try{e=e.trim();var t=e.match(/^([^\$]*?)(\$(?:[\,\,]?\d{1,3})+(?:\.\d{2})?)(.*?)$/)||[];return 4===t.length?t[2]:""}catch(e){return usi_commons.log("Error: "+e.message),""}},usi_dom.get_absolute_url=function(){var e;return function(t){return(e=e||document.createElement("a")).href=t,e.href}}(),usi_dom.format_number=function(e,t){var n="";if("number"==typeof e){t=t||0;var o=e.toFixed(t).split(/\./g);if(1==o.length||2==o.length)n=o[0].replace(/./g,function(e,t,n){return t&&"."!==e&&(n.length-t)%3==0?","+e:e}),2==o.length&&(n+="."+o[1])}return n},usi_dom.format_currency=function(e,t,n){var o="";return e=Number(e),!1===isNaN(e)&&("object"==typeof Intl&&"function"==typeof Intl.NumberFormat?(t=t||"en-US",n=n||{style:"currency",currency:"USD"},o=e.toLocaleString(t,n)):o=e),o},usi_dom.to_decimal_places=function(e,t){if(null!=e&&"number"==typeof e&&null!=t&&"number"==typeof t){if(0==t)return parseFloat(Math.round(e));for(var n=10,o=1;o<t;o++)n*=10;return parseFloat(Math.round(e*n)/n)}return null},usi_dom.trim_string=function(e,t,n){return n=n||"",(e=e||"").length>t&&(e=e.substring(0,t),""!==n&&(e+=n)),e},usi_dom.attach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);usi_dom.detach_event(e,t,o),o.addEventListener?o.addEventListener(e,t,!1):o.attachEvent("on"+e,t)},usi_dom.detach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);o.removeEventListener?o.removeEventListener(e,t,!1):o.detachEvent("on"+e,t)},usi_dom.find_supported_element=function(e,t){return(t=t||document)===window?window:!0===usi_dom.is_event_supported(e,t)?t:t===document?window:usi_dom.find_supported_element(e,document)},usi_dom.is_event_supported=function(e,t){return null!=t&&void 0!==t["on"+e]},usi_dom.is_defined=function(e,t){if(null==e)return!1;if(""===(t||""))return!1;var n=!0,o=e;return t.split(".").forEach(function(e){!0===n&&(null==o||"object"!=typeof o||!1===o.hasOwnProperty(e)?n=!1:o=o[e])}),n},usi_dom.observe=function(e,t,n){var o=location.href,r=window.MutationObserver||window.WebkitMutationObserver;return t=t||{onUrlUpdate:!1,observerOptions:{childList:!0,subtree:!0}},function(e,n){var i=null,u=function(){var e=location.href;t.onUrlUpdate&&e!==o?(n(),o=e):n()};return r?(i=new r(function(e){var r=location.href,i=e[0].addedNodes.length||e[0].removedNodes.length;i&&t.onUrlUpdate&&r!==o?(n(),o=r):i&&n()})).observe(e,t.observerOptions):window.addEventListener&&(e.addEventListener("DOMNodeInserted",u,!1),e.addEventListener("DOMNodeRemoved",u,!1)),i}}(),usi_dom.params_to_object=function(e){var t={};""!=(e||"")&&e.split("&").forEach(function(e){var n=e.split("=");2===n.length?t[decodeURIComponent(n[0])]=decodeURIComponent(n[1]):1===n.length&&(t[decodeURIComponent(n[0])]=null)});return t},usi_dom.object_to_params=function(e){var t=[];if(null!=e)for(var n in e)!0===e.hasOwnProperty(n)&&t.push(encodeURIComponent(n)+"="+(null==e[n]?"":encodeURIComponent(e[n])));return t.join("&")},usi_dom.interval_with_timeout=function(e,t,n,o){if("function"!=typeof e)throw new Error("usi_dom.interval_with_timeout(): iterationFunction must be a function");if(null==t)t=function(e){return e};else if("function"!=typeof t)throw new Error("usi_dom.interval_with_timeout(): timeoutCallback must be a function");if(null==n)n=function(e){return e};else if("function"!=typeof n)throw new Error("usi_dom.interval_with_timeout(): completeCallback must be a function");var r=(o=o||{}).intervalMS||20,i=o.timeoutMS||2e3;if("number"!=typeof r)throw new Error("usi_dom.interval_with_timeout(): intervalMS must be a number");if("number"!=typeof i)throw new Error("usi_dom.interval_with_timeout(): timeoutMS must be a number");var u=!1,l=new Date,a=setInterval(function(){var o=new Date-l;if(o>=i)return clearInterval(a),t({elapsedMS:o});!1===u&&(u=!0,e(function(e,t){if(u=!1,!0===e)return clearInterval(a),(t=t||{}).elapsedMS=new Date-l,n(t)}))},r)},usi_dom.load_external_stylesheet=function(e,t,n){if(""!==(e||"")){""===(t||"")&&(t="usi_stylesheet_"+(new Date).getTime());var o={url:e,id:t},r=document.getElementsByTagName("head")[0];if(null!=r){var i=document.createElement("link");i.type="text/css",i.rel="stylesheet",i.id=o.id,i.href=e,usi_dom.attach_event("load",function(){if(null!=n)return n(null,o)},i),r.appendChild(i)}}else if(null!=n)return n(null,o)},usi_dom.ready=function(e){void 0!==document.readyState&&"complete"===document.readyState?e():window.addEventListener?window.addEventListener("load",e,!0):window.attachEvent?window.attachEvent("onload",e):setTimeout(e,5e3)},usi_dom.fit_text=function(e,t){t||(t={});var n={multiLine:!0,minFontSize:.1,maxFontSize:20,widthOnly:!1},o={};for(var r in n)t.hasOwnProperty(r)?o[r]=t[r]:o[r]=n[r];var i=Object.prototype.toString.call(e);function u(e,t){var n,o,r,i,u,l,a,s;r=e.innerHTML,u=parseInt(window.getComputedStyle(e,null).getPropertyValue("font-size"),10),i=function(e){var t=window.getComputedStyle(e,null);return(e.clientWidth-parseInt(t.getPropertyValue("padding-left"),10)-parseInt(t.getPropertyValue("padding-right"),10))/u}(e),o=function(e){var t=window.getComputedStyle(e,null);return(e.clientHeight-parseInt(t.getPropertyValue("padding-top"),10)-parseInt(t.getPropertyValue("padding-bottom"),10))/u}(e),i&&(t.widthOnly||o)||(t.widthOnly?usi_commons.log("Set a static width on the target element "+e.outerHTML):usi_commons.log("Set a static height and width on the target element "+e.outerHTML)),-1===r.indexOf("textFitted")?((n=document.createElement("span")).className="textFitted",n.style.display="inline-block",n.innerHTML=r,e.innerHTML="",e.appendChild(n)):n=e.querySelector("span.textFitted"),t.multiLine||(e.style["white-space"]="nowrap"),l=t.minFontSize,s=t.maxFontSize;for(var c=l,d=1e3;l<=s&&d>0;)d--,a=s+l-.1,n.style.fontSize=a+"em",n.scrollWidth/u<=i&&(t.widthOnly||n.scrollHeight/u<=o)?(c=a,l=a+.1):s=a-.1;n.style.fontSize!==c+"em"&&(n.style.fontSize=c+"em")}"[object Array]"!==i&&"[object NodeList]"!==i&&"[object HTMLCollection]"!==i&&(e=[e]);for(var l=0;l<e.length;l++)u(e[l],o)});
'undefined'==typeof usi_url&&(usi_url={},usi_url.URL=function(a){a=a||location.href;var b=document.createElement('a');if(b.href=a,this.full=b.href||'',this.protocol=(b.protocol||'').split(':')[0],this.host=b.host||'',-1!=this.host.indexOf(':')&&(this.host=this.host.substring(0,this.host.indexOf(':'))),this.port=b.port||'',this.hash=b.hash||'',this.baseURL='',this.tld='',this.domain='',this.subdomain='',this.domain_tld='',''!==this.protocol&&''!==this.host){this.baseURL=this.protocol+'://'+this.host+'/';var c=this.host.split(/\./g);if(2<=c.length){if(-1<['co','com','org','net','int','edu','gov','mil'].indexOf(c[c.length-2])&&2===c[c.length-1].length){var d=c.pop(),e=c.pop();this.tld=e+'.'+d}else this.tld=c.pop()}0<c.length&&(this.domain=c.pop(),0<c.length&&(this.subdomain=c.join('.'))),this.domain_tld=this.domain+'.'+this.tld}var f=b.pathname||'';0!==f.indexOf('/')&&(f='/'+f),this.path=new usi_url.Path(f),this.params=new usi_url.Params((b.search||'').substr(1))},usi_url.URL.prototype.build=function(a,b,c){var d='';return''!==this.protocol&&''!==this.host&&(null==a&&(a=!0),null==b&&(b=!0),null==c&&(c=!0),!0==a&&(d+=this.protocol+':'),d+='//'+this.host,''!==this.port&&(d+=':'+this.port),!0==b&&(d+=this.path.full,!0==c&&0<Object.keys(this.params.parameters).length&&(d+='?',d+=this.params.build()))),d},usi_url.Path=function(a){a=a||'',this.full=a,this.directories=[],this.filename='';for(var b=a.substr(1).split(/\//g);0<b.length;)1===b.length?this.filename=b.shift():this.directories.push(b.shift());this.has_directory=function(a){return-1<this.directories.indexOf(a)},this.contains=function(a){return-1<this.full.indexOf(a)}},usi_url.Params=function(a){a=a||'',this.full=a,this.parameters=function(a){var b={};if(1===a.length&&''===a[0])return b;for(var c,d,e,f=0;f<a.length;f++)if(e=a[f].split('='),c=e[0]&&e[0].replace(/\+/g,' '),d=e[1]&&e[1].replace(/\+/g,' '),1===e.length)b[c]='';else try{b[c]=decodeURIComponent(d)}catch(a){b[c]=d}return b}(a.split('&')),this.count=Object.keys(this.parameters).length,this.get=function(a){return a in this.parameters?this.parameters[a]:null},this.has=function(a){return a in this.parameters},this.set=function(a,b){this.parameters[a]=b,this.count=Object.keys(this.parameters).length},this.remove=function(a){!0===this.has(a)&&delete this.parameters[a],this.count=Object.keys(this.parameters).length},this.build=function(){var a=this,b=[];for(var c in a.parameters)!0===a.parameters.hasOwnProperty(c)&&b.push(c+'='+encodeURIComponent(a.parameters[c]));return b.join('&')},this.remove_usi_params=function(a){var b=this;for(var c in a=a||[],-1===a.indexOf('usi_')&&a.push('usi_'),b.parameters)if(!0===b.parameters.hasOwnProperty(c)){var d=!1;a.forEach(function(a){0===c.indexOf(a)&&(d=!0)}),d&&b.remove(c)}},this.remove_all=function(){var a=this;for(var b in a.parameters)!0===a.parameters.hasOwnProperty(b)&&a.remove(b)}});
"undefined"==typeof usi_date&&(usi_date={},usi_date.PSTOffsetMinutes=480,usi_date.localOffsetMinutes=(new Date).getTimezoneOffset(),usi_date.offsetDeltaMinutes=usi_date.localOffsetMinutes-usi_date.PSTOffsetMinutes,usi_date.toPST=function(e){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*usi_date.offsetDeltaMinutes*1e3)},usi_date.add_hours=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*60*1e3)},usi_date.add_minutes=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*1e3)},usi_date.add_seconds=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+1e3*t)},usi_date.get_week_number=function(e){var t={year:-1,weekNumber:-1};try{if(usi_date.is_date(e)){var a=new Date(Date.UTC(e.getFullYear(),e.getMonth(),e.getDate()));a.setUTCDate(a.getUTCDate()+4-(a.getUTCDay()||7));var s=new Date(Date.UTC(a.getUTCFullYear(),0,1)),i=Math.ceil(((a-s)/864e5+1)/7);t.year=a.getUTCFullYear(),t.weekNumber=i}}catch(e){}finally{return t}},usi_date.is_date=function(e){return null!=e&&"object"==typeof e&&e instanceof Date==!0&&!1===isNaN(e.getTime())},usi_date.is_date_within_range=function(e,t,a){if(void 0===e&&(e=usi_date.set_date()),!1===usi_date.is_date(e))return!1;var s=usi_date.string_to_date(t,!1),i=usi_date.string_to_date(a,!1),r=usi_date.toPST(e);return r>=s&&r<i},usi_date.is_after=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()>a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_before=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()<a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_between=function(e,t){return usi_date.check_format(e,t),usi_date.is_after(e)&&usi_date.is_before(t)},usi_date.check_format=function(e,t){(-1!=e.indexOf(" ")||t&&-1!=t.indexOf(" "))&&"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error("Incorrect format: Use YYYY-MM-DDThh:mm:ss")},usi_date.is_date_after=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)>a},usi_date.is_date_before=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)<a},usi_date.string_to_date=function(e,t){t=t||!1;var a=null,s=/^[0-2]?[0-9]\/[0-3]?[0-9]\/\d{4}(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e),i=/^(\d{4}\-[0-2]?[0-9]\-[0-3]?[0-9])(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e);if(2===(s||[]).length){if(a=new Date(e),""===(s[1]||"")&&!0===t){var r=new Date;a=usi_date.add_hours(a,r.getHours()),a=usi_date.add_minutes(a,r.getMinutes()),a=usi_date.add_seconds(a,r.getSeconds())}}else if(3===(i||[]).length){var o=i[1].split(/\-/g),u=o[1]+"/"+o[2]+"/"+o[0];return u+=i[2]||"",usi_date.string_to_date(u,t)}return a},usi_date.set_date=function(){var e=new Date,t=usi_commons.gup("usi_force_date");if(""!==t){t=decodeURIComponent(t);var a=usi_date.string_to_date(t,!0);null!=a?(e=a,usi_cookies.set("usi_force_date",t,usi_cookies.expire_time.hour),usi_commons.log("Date forced to: "+e)):usi_cookies.del("usi_force_date")}else e=null!=usi_cookies.get("usi_force_date")?usi_date.string_to_date(usi_cookies.get("usi_force_date"),!0):new Date;return e},usi_date.diff=function(e,t,a,s){null==s&&(s=1),""!=(a||"")&&(a=usi_date.get_units(a));var i=null;if(!0===usi_date.is_date(t)&&!0===usi_date.is_date(e))try{var r=Math.abs(t-e);switch(a){case"ms":i=r;break;case"seconds":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3),s);break;case"minutes":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60),s);break;case"hours":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"days":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s)}}catch(e){i=null}return i},usi_date.convert_units=function(e,t,a,s){var i=null,r=null;switch(usi_date.get_units(t)){case"days":i=1e6*e*1e3*60*60*24;break;case"hours":i=1e6*e*1e3*60*60;break;case"minutes":i=1e6*e*1e3*60;break;case"seconds":i=1e6*e*1e3;break;case"ms":i=1e6*e}switch(usi_date.get_units(a)){case"days":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s);break;case"hours":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"minutes":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60),s);break;case"seconds":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3),s);break;case"ms":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6),s)}return r},usi_date.get_units=function(e){var t="";switch(e.toLowerCase()){case"days":case"day":case"d":t="days";break;case"hours":case"hour":case"hrs":case"hr":case"h":t="hours";break;case"minutes":case"minute":case"mins":case"min":case"m":t="minutes";break;case"seconds":case"second":case"secs":case"sec":case"s":t="seconds";break;case"ms":case"milliseconds":case"millisecond":case"millis":case"milli":t="ms"}return t});

if (typeof usi_analytics === 'undefined') {
	usi_analytics = {
		cookie_length : 30,
		load_script:function(source) {
			var docHead = document.getElementsByTagName("head")[0];
			if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			docHead.appendChild(newScript);
		},
		get_id:function() {
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_analytics') == null && usi_cookies.get('usi_id') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_analytics') != null) usi_id = usi_cookies.get('usi_analytics');
				if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
				usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		send_page_hit:function(report_type, companyID, data1) {
			var qs = "";
			if (data1) qs += data1;
			usi_analytics.load_script(usi_commons.domain + "/analytics/hit.js?usi_a="+usi_analytics.get_id(companyID)+"&usi_t="+(Date.now())+"&usi_r="+report_type+"&usi_c="+companyID+qs+"&usi_u="+encodeURIComponent(location.href));
		}
	};
}
		usi_cookieless = true;
		usi_app = {};
		usi_app.checking_minicart = false;
		usi_app.onclick_bound = false;
		usi_app.main = function () {

			// General
			usi_app.url = location.href.toLowerCase();
			usi_app.url2 = new usi_url.URL(location.href.toLowerCase());
			usi_app.last_url = undefined;
			usi_app.coupon = usi_cookies.value_exists("usi_coupon_applied") ? "" : usi_commons.gup_or_get_cookie("usi_coupon", usi_cookies.expire_time.week, true);
			usi_app.page_visits = usi_app.get_page_visits();
			usi_app.phone_skus = ['464', '518', '517', '631', '538', '534', '537', '295', '627', '645', '648', '352', '535', '539', '619', '415', '536', '617', '414'];

			// Pages
			usi_app.is_product_page = usi_app.url2.path.filename == "p";
			usi_app.is_smartphone_page = usi_app.url2.path.filename == "smartphones" || usi_app.url2.path.filename == "smartphones-5g";
			usi_app.is_checkout_page = usi_app.url.indexOf("/checkout/") != -1;
			usi_app.is_checkout_page_p1 = usi_app.url.indexOf("/checkout/#/cart") != -1;
			usi_app.is_checkout_page_p2 = usi_app.url.indexOf("/checkout/#/email") != -1;
			usi_app.is_checkout_page_p3 = usi_app.url.indexOf("/checkout/#/shipping") != -1;
			usi_app.is_checkout_page_p4 = usi_app.url.indexOf("/checkout/#/payment") != -1;
			usi_app.is_confirmation_page = usi_app.url.indexOf("/orderplaced") != -1;
			usi_app.is_warranty_page = usi_app.url.indexOf("warranty") != -1; // https://www.motorola.com/us/warranty
			usi_app.is_search_results_page = usi_app.url.indexOf("?_q=") != -1; // https://www.motorola.com/us/raz?_q=raz&map=ft
			usi_app.is_error_page = usi_app.url.indexOf("error") != -1; // https://www.motorola.com/us/error
			usi_app.is_login_page = usi_app.url.indexOf("login") != -1; // https://www.motorola.com/us/login
			usi_app.is_motorola_mail_page = usi_app.url.indexOf("motorola-mail") != -1;
			usi_app.is_country_selector_page = usi_app.url.indexOf("country-selector") != -1; // https://www.motorola.com/country-selector
			usi_app.is_suppressed_pages = usi_app.url.indexOf("about") != -1 || usi_app.url.indexOf("content") != -1 || usi_app.url.indexOf("blog") != -1 || usi_app.url.indexOf("legal") != -1 || usi_app.url.indexOf("moto-care") != -1 || usi_app.url.indexOf("motorola-mail") != -1 || usi_app.url.indexOf("account") != -1 || usi_app.url.indexOf("financing") != -1 || usi_app.url.indexOf("enterprise") != -1 || usi_app.url.indexOf("custhelp") != -1 || usi_app.url.indexOf("login") != -1 || usi_app.url.indexOf("smartphones-motorola-edge-30-fusion/p") != -1;
			usi_app.is_email_or_crm_pages = usi_app.url.toLowerCase().indexOf("utm_medium=email") != -1 || usi_app.url.toLowerCase().indexOf("utm_source=crm") != -1;
			usi_app.is_edge_pages = usi_app.url.toLowerCase().indexOf("smartphones-motorola-edge-family") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-motorola-edge/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-motorola-edge/p?skuId=352") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-motorola-one-5g-ace/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-motorola-one-5g-ace/p?skuId=537") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g100/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g100/p?skuId=627") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g100/p?skuId=645") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-motorola-edge/p?skuId=17") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-motorola-one-5g-ace/p?skuId=6") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g100/p?skuId=76") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g100/p?skuId=79") != -1;
			usi_app.is_g_pure_pages = usi_app.url.toLowerCase().indexOf("smartphones-moto-g-family") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g7-plus/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g7-plus/p?skuId=523") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-e/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-e/p?skuId=414") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-play/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-play/p?skuId=536") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-fast/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-fast/p?skuId=415") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-power/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-power/p?skuId=617") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-stylus/p") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-stylus/p?skuId=586") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-e/p?skuId=13") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-play/p?skuId=11") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-fast/p?skuId=32") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-power/p?skuId=10") != -1 || usi_app.url.toLowerCase().indexOf("smartphones-moto-g-stylus/p?skuId=9") != -1;
			usi_app.is_suppressed_moto_g_december = (usi_app.url.indexOf("smartphones-moto-g-play-gen-2/p") != -1 && usi_date.is_before('2022-12-12T23:59'));

			// Booleans
			usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.day, true) != "";
			usi_app.is_suppressed = usi_app.is_confirmation_page;
			usi_app.minicart_visible = false;
			usi_app.onclick_loaded = false;
			usi_app.is_us_site = usi_app.url.match("/us/") != null;
			usi_app.is_es_site = usi_app.url.match("/us-es/") != null;
			usi_app.is_return_visitor = usi_app.check_if_return_visitor() || usi_commons.gup_or_get_cookie("usi_force_return", usi_cookies.expire_time.day, true) != "";

			// Load pixel on confirmation page
			if (usi_app.is_confirmation_page) {
				usi_commons.load_script("https://www.upsellit.com/active/motorola_pixel.jsp");
			}

			// Apply coupons
			if (usi_app.is_checkout_page && usi_app.coupon != "" && document.querySelector('#cart-coupon') !== null) {
				setTimeout(function() {
					usi_app.apply_coupon();
				}, 1000);
				return;
			}
			
			// Place suppression on entire session if utm_medium=email or utm_source=crm is in URL
			if (usi_app.is_email_or_crm_pages) {
				usi_cookies.set("usi_suppress", "1", usi_cookies.expire_time.week)
			}

			// Check suppressions
			if (usi_app.is_suppressed || usi_app.is_motorola_mail_page || usi_app.is_suppressed_pages || usi_cookies.value_exists("usi_suppress")) {
				return usi_commons.log("[ main ] Company is suppressed");
			}

			// Check for Tiktok traffic
			if (usi_app.url.indexOf("utm_source=tiktok") != -1) {
				usi_cookies.set("usi_tiktok_traffic", '1', usi_cookies.expire_time.week);
			}

			// Monitor minicart status
			if (!usi_app.checking_minicart) {
				usi_app.checking_minicart = true;
				usi_app.check_for_minicart();
			}

			// Bind event handlers
			
			
			console.log("running USI main");

			// Load campaigns
			usi_app.load();
		};

		usi_app.load = function (id) {
			// Don't load other solutions while onclick config is showing
			if (usi_app.onclick_loaded) return;

			// Clean up previous solutions
			if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
				usi_js.cleanup();
			}

			// Load additional solutions
			if (!id) {
				usi_app.side_load();
				
			}

			// Get subtotal
			var subtotal = Number(usi_cookies.get('usi_subtotal') || '0');
			if (usi_app.is_checkout_page_p1 && subtotal == "0") {
				subtotal = window.ordervalue;
				usi_cookies.set("usi_subtotal", encodeURIComponent(subtotal), usi_cookies.expire_time.week);
			}
			usi_commons.log("[ load ] subtotal:", subtotal);

			// ======================= US_02 ======================= Abandon
			// =====================================================
			// Cart over 150
			// Exclude users who visited URLs that: Contain utm_source=tiktok
			// Exclude select urls & pages
			

			// ======================= US_03 ======================= Abandon
			// =====================================================
			// Cart under 149
			// Exclude users who visited URLs that: Contain utm_source=tiktok
			// Exclude select urls & pages
			
			
			// ======================= US_06 ======================= Proactive - 1 secs
			// =====================================================
			// New users
			// Has not submitted email in the past
			// United States of America
			// Exclude select urls & pages
			var us_06_exclusion_list = [
				'pages.motorola-mail.com',
				'/blog',
				'cloud.motorola-mail.com',
				'/es/'
			];
			if (id === "us_06" || (!usi_app.is_return_visitor && !usi_cookies.value_exists('usi_email_submitted') && usi_app.country == 'us' && usi_app.url_launch_allowed(us_06_exclusion_list) && !usi_app.is_checkout_page && !usi_cookies.value_exists("usi_lc_launched")) && !usi_app.is_suppressed_moto_g_december) {
				if (usi_app.is_us_site) {
					usi_commons.log('[ load ] * * * US_06 * * *');
					usi_commons.load_view("5UGlVUkexySBthnuUzGX3bP", "37891", usi_commons.device);
				} else if (usi_app.is_es_site) {
					usi_commons.log('[ load ] * * * US_06 * * *');
					usi_commons.load_view("zC4aTkaMsRZxk4Rm4ABQeps", "37965", usi_commons.device);
				}
				return;
			}

			// ======================= US_07 ======================= Abandon
			// =====================================================
			// Cart under 149 (we already have a campaign for this. looks like they have one that launches no matter what)
			// Exclude users who visited URLs that: Contain utm_source=tiktok
			// Exclude select urls & pages
			
			
			if (usi_cookies.value_exists("usi_lc_launched")) {
				if (usi_app.is_us_site && usi_app.is_edge_pages) {
					usi_commons.log('[ load ] * * * US Motorola Edge 2021 (EN) Campaign * * *');
					usi_commons.load_view("IRZjfapW7Rr2fEEkNtYkGBM", "38944", usi_commons.device);
				} else if (usi_app.is_us_site && usi_app.is_g_pure_pages) {
					usi_commons.log('[ load ] * * * US Moto G Pure (EN) Campaign * * *');
					usi_commons.load_view("UZ3QDUEQEIWn0Lf0UCQ0TT2", "38968", usi_commons.device);
				} else if (usi_app.is_es_site && usi_app.is_edge_pages) {
					usi_commons.log('[ load ] * * * US Motorola Edge 2021 (ES) Campaign * * *');
					usi_commons.load_view("zr4CdC0Ha1KEF9aQxMTaGNG", "38946", usi_commons.device);
				}  else if (usi_app.is_es_site && usi_app.is_g_pure_pages) {
					usi_commons.log('[ load ] * * * US Moto G Pure (ES) Campaign * * *');
					usi_commons.load_view("dUCzNIjmUn1zL8JslK2Army", "38970", usi_commons.device);
				}
				
			}
			
			if (usi_cookies.value_exists("usi_lc_launched") && usi_cookies.value_exists("usi_has_phone_sku") && usi_app.is_checkout_page && usi_app.is_us_site) {
				if (usi_date.is_between('2022-09-22T00:00', '2022-10-10T23:59')) {
					usi_commons.load_view("moZkJtt5UhTIgYt84UmCkVD", "40128", usi_commons.device + "_edge");
				} else {
					usi_commons.load_view("moZkJtt5UhTIgYt84UmCkVD", "40128", usi_commons.device);
				}
			}
			
			console.log("running USI load");

		};

		

		/**
		 * We load these on every page (IN ADDITION) to the other solutions
		 */
		usi_app.side_load = function () {

			// =================== US_04 & US_05 =================== Proactive - 3 secs
			// =====================================================
			// US_04 -> Return Users
			// US_05 -> New Users
			// Has not submitted email in the past
			// United States of America
			// Exclude select urls & pages
			var us_04_exclusion_list = [
				'pages.motorola-mail.com',
				'www.motorola.com/us/epp',
				'blog',
				'cloud.motorola-mail.com',
				'/es/'
			];
			if (!usi_cookies.value_exists('usi_email_submitted') && usi_app.country == 'us' && usi_app.url_launch_allowed(us_04_exclusion_list) && !usi_app.is_checkout_page && usi_app.page_visits > 2 && !usi_cookies.value_exists("usi_corner_modal_closed") && !usi_cookies.value_exists("usi_5off_offer_redeemed")) {
				setTimeout(function() {
					if (usi_app.is_us_site) {
						if (usi_app.is_return_visitor) {
							usi_commons.log('[ load ] * * * US_04 * * *');
							if (typeof(usi_app.last_loaded) === "undefined" || usi_app.last_loaded != "37911") {
								usi_app.last_loaded = "37911";
								usi_commons.load("O9imEB58uhLBHs2wBqffItM", "37911", usi_commons.device);
							}
						} else {
							usi_commons.log('[ load ] * * * US_05 * * *');
							if (typeof(usi_app.last_loaded) === "undefined" || usi_app.last_loaded != "37877") {
								usi_app.last_loaded = "37877";
								usi_commons.load("QGk4yY5bj5ASOoSCwDjnnYM", "37877", usi_commons.device);
							}
						}
					} else if (usi_app.is_es_site) {
						if (usi_app.is_return_visitor) {
							usi_commons.log('[ load ] * * * US_04 * * *');
							if (typeof(usi_app.last_loaded) === "undefined" || usi_app.last_loaded != "37995") {
								usi_app.last_loaded = "37995";
								usi_commons.load("beAIUkF07z77okCW5mUFp8U", "37995", usi_commons.device);
							}
						} else {
							usi_commons.log('[ load ] * * * US_05 * * *');
							if (typeof(usi_app.last_loaded) === "undefined" || usi_app.last_loaded != "37993") {
								usi_app.last_loaded = "37993";
								usi_commons.load("E8aZ1CuFA8knqro2evJFraY", "37993", usi_commons.device);
							}
						}
					}
				}, 3000);
			}
		};

		

		usi_app.url_launch_allowed = function (exclusion_list) {
			var allowed = true;
			if (exclusion_list && exclusion_list.length > 0) {
				for (var i = 0; i < exclusion_list.length; i++) {
					if (location.href.indexOf(exclusion_list[i]) !== -1) {
						// Excluded keyword found in url
						allowed = false;
						break;
					}
				}
			}
			return allowed;
		};

		usi_app.check_for_minicart = function () {
			var minicart_el = document.querySelector('.vtex-minicart-2-x-drawer');
			if (minicart_el) {
				var is_hidden = minicart_el.getAttribute('aria-hidden') == "true";
				if (!is_hidden && !usi_app.minicart_visible) {
					usi_app.minicart_visible = true;
					usi_commons.log('[ check_for_minicart ] Minicart opened!');
					setTimeout(function () {
						usi_app.detect_minicart_load(minicart_el, function () {
							usi_app.save_minicart(minicart_el);
						});
					}, 1000);
				} else if (is_hidden && usi_app.minicart_visible) {
					usi_app.minicart_visible = false;
					usi_commons.log('[ check_for_minicart ] Minicart closed!');
				}
			}
			setTimeout(usi_app.check_for_minicart, 1000);
		};

		usi_app.detect_minicart_load = function (el, cb) {
			var cart_empty_el = el.querySelector('.vtex-rich-text-0-x-wrapper p.lh-copy.vtex-rich-text-0-x-paragraph');
			if (cart_empty_el) {
				// Empty cart detected
				usi_commons.log('[ detect_minicart_load ] Empty cart detected!');
				usi_cookies.flush("usi_prod_");
				usi_cookies.del("usi_subtotal");
				usi_app.load();
			} else {
				// Wait for minicart to finish loading
				var total_el = el.querySelector('#items-price .vtex-checkout-summary-0-x-price');
				if (total_el && total_el.textContent !== "TBD") {
					setTimeout(function () {
						cb();
					}, 1000);
				} else {
					setTimeout(function () {
						usi_app.detect_minicart_load(el, cb);
					}, 250);
				}
			}
		};

		usi_app.save_minicart = function (el) {
		
			// Scrape total
			var subtotal = '0.00';
			var total_el = el.querySelector('#items-price .vtex-checkout-summary-0-x-price');
			if (total_el && total_el.textContent && usi_dom.string_to_decimal(total_el.textContent)) {
				subtotal = usi_dom.string_to_decimal(total_el.textContent).toFixed(2);
			}
		
			// Re-scrape cart if subtotal is different
			if (usi_cookies.get("usi_subtotal") !== subtotal) {
		
				// Re-save subtotal
				usi_cookies.set("usi_subtotal", encodeURIComponent(subtotal), usi_cookies.expire_time.week);
		
				// Scrape minicart
				var cart_prefix = "usi_prod_";
				usi_cookies.flush(cart_prefix);
		
				usi_app.cart = {
					items: usi_app.scrape_minicart(el),
					subtotal: subtotal
				};
		
				if (typeof usi_app.cart.items != "undefined") {
					usi_app.cart.items.forEach(function (product, index) {
						var prop;
						if (index >= 3) return;
						for (prop in product) {
							if (product.hasOwnProperty(prop)) {
								usi_cookies.set(cart_prefix + prop + "_" + (index + 1), encodeURIComponent(product[prop]), usi_cookies.expire_time.week);
							}
							if (usi_app.phone_skus.includes(usi_cookies.get("usi_prod_pid_" + (index + 1)))) {
								usi_cookies.set("usi_has_phone_sku", "1", usi_cookies.expire_time.week);
							}
						}
					});
				}
				usi_commons.log('[ save_minicart ] cart:', usi_app.cart);
		
				// Load solutions
				usi_app.load();
			}
		};

		usi_app.scrape_minicart = function (el) {
			try {
				var cart_rows = el.querySelectorAll('.vtex-flex-layout-0-x-flexRow .flex.mt0.mb0.pt5.pb6');
				var items = [], product;
				cart_rows.forEach(function (container) {
					product = {};
		
					var name_el = container.querySelector("a.vtex-product-list-0-x-productName");
					if (name_el) {
						product.link = name_el.href;
						product.name = name_el.textContent;
						var id = name_el.getAttribute('id');
						if (id && id.indexOf('name-') !== -1) {
							product.pid = id.replace('name-', '');
						}
					}
		
					var image_el = container.querySelector("img.vtex-product-list-0-x-productImage");
					if (image_el) {
						product.image = image_el.src;
					}
		
					var price_el = container.getElementsByClassName("vtex-product-list-0-x-price")[1];
					if (price_el && usi_dom.string_to_decimal(price_el.textContent)) {
						product.price = usi_dom.string_to_decimal(price_el.textContent).toFixed(2);
					}
					
					if (document.querySelector(".vtex-product-list-0-x-currencyContainer") != null) {
						var old_price_el = container.querySelector(".vtex-product-list-0-x-currencyContainer");
						if (old_price_el && usi_dom.string_to_decimal(old_price_el.textContent)) {
							product.old_price = usi_dom.string_to_decimal(old_price_el.textContent).toFixed(2);
						}
					}
		
					items.push(product);
				});
				return items;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.apply_coupon = function () {
			var coupon_input = document.querySelector(".totalizers .coupon-fieldset .coupon-fields #cart-coupon");
			var coupon_button = document.querySelector(".totalizers .coupon-fieldset .coupon-fields #cart-coupon-add");
			if (coupon_input !== null && coupon_button !== null) {

				coupon_input.value = usi_app.coupon;
				var evt = document.createEvent('HTMLEvents');
				evt.initEvent("change", false, true);
				coupon_input.dispatchEvent(evt);

				coupon_button.disabled = false;
				coupon_button.click();
				setTimeout(usi_app.post_apply_coupon, 5000);
				usi_commons.log("[ apply_coupon ] Coupon applied");

				usi_cookies.set("usi_coupon_applied", usi_app.coupon, usi_cookies.expire_time.week);
				usi_cookies.del("usi_coupon");
				usi_app.coupon = "";

			} else {
				if (usi_app.coupon_attempts == undefined) {
					usi_app.coupon_attempts = 0;
				} else if (usi_app.coupon_attempts >= 5) {
					usi_commons.report_error("[ apply_coupon ] Coupon elements not found");
					return;
				}
				usi_app.coupon_attempts++;
				usi_commons.log("[ apply_coupon ] Coupon elements missing, trying again. Tries: " + usi_app.coupon_attempts);
				setTimeout(usi_app.apply_coupon, 1000);
			}
		};

		usi_app.post_apply_coupon = function () {
			var error_element = document.querySelector(".vtex-front-messages-placeholder-opened .vtex-front-messages-detail");
			var error_message_exists = error_element != null && error_element.textContent.trim() != "";
			if (error_message_exists) {
				usi_commons.report_error("[ post_apply_coupon ] Coupon error message seen");
			} else {
				usi_commons.log_success("[ post_apply_coupon ] Coupon application was successful");
			}
		};

		usi_app.check_if_return_visitor = function () {
			var return_visitor = false;
			var cookie_name = "usi_return_visitor";
			var now = usi_date.set_date();
			try {
				if (usi_cookies.value_exists(cookie_name) === false) {
					usi_cookies.set(cookie_name, now, usi_cookies.expire_time.never, true);
				}
				var previous = new Date(usi_cookies.get(cookie_name));
				if (usi_date.is_date(previous)) {
					return_visitor = usi_date.diff(previous, now, 'hour', 2) > 24;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return return_visitor;
		};

		usi_app.get_page_visits = function () {
			var page_visits = Number(usi_cookies.get("usi_page_visits")) + 1;
			usi_cookies.set("usi_page_visits", page_visits, usi_cookies.expire_time.day);
			usi_commons.log("[ get_page_visits ] Page visit: " + page_visits);
			return page_visits;
		};

		usi_app.check_for_change = function(){
			if (usi_app.current_page == undefined || usi_app.current_page != location.href.replace(location.search, "")) {
				usi_app.current_page = location.href.replace(location.search, "");
				usi_app.main();
				usi_commons.log("USI: running usi main");
			}
		};

		usi_app.session_data_callback = function() {
			usi_app.country = usi_app.session_data.country;
			if (!usi_app.check_for_change_interval) {
				usi_app.check_for_change_interval = setInterval(usi_app.check_for_change, 1000);
			}
		};

		setTimeout(function () {
			usi_commons.load_session_data();
		}, 1000);

		usi_app.monitor_for_analytics = function() {
			try {
				if (typeof(usi_app.last_url) === "undefined" || usi_app.last_url != location.href) {
					usi_app.last_url = location.href;
					//usi_analytics.send_page_hit("VIEW", "5036");
				}
				setTimeout(usi_app.monitor_for_analytics, 2000);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.monitor_for_analytics();

	} catch (err) {
		usi_commons.report_error(err);
	}
}