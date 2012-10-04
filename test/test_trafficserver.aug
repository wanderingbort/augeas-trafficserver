module Test_trafficserver = 
  let teststring = "url_regex=^http://bar.com ttl-in-cache=5184000 cache-responses-to-cookies=1
		    url_regex=^http://foo.com ttl-in-cache=2d54m37s87
"

  let _ = print_regexp (lens_ctype Trafficserver_cache.cache_lns)
  let _ = print_endline ""

  test Trafficserver_cache.cache_lns get teststring = 
	{ "url_regex" = "^http://bar.com" 
		{ "ttl-in-cache" = "5184000" }
		{ "cache-responses-to-cookies" = "1" }
	}
	{ "url_regex" = "^http://foo.com" 
		{ "ttl-in-cache" = "2d54m37s87" }
	}

	
  let _ = print_regexp (lens_ctype Trafficserver_plugin.plugin_lns)
  let _ = print_endline ""

  let plugintring = "/foo/bar.so I am an \"arg\" # this is the foobar plugin
"

  test Trafficserver_plugin.plugin_lns get plugintring = 
	{ "plugin" = "/foo/bar.so"
		{ "args" = "I am an \"arg\"" }
		{ "#comment" = "this is the foobar plugin" }
	}

  let _ = print_regexp (lens_ctype Trafficserver_remap.remap_lns)
  let _ = print_endline ""

  let remapstring = "map http://localhost/stat/ http://{stat} @src_ip=127.0.0.1 @action=allow
"

  test Trafficserver_remap.remap_lns get remapstring = 
  { "map" = "http://localhost/stat/"
    {"replacement" = "http://{stat}"}
    {"@src_ip" = "127.0.0.1"}
    {"@action" = "allow"}
  }

