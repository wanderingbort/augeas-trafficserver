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

	
  let _ = print_regexp (lens_ctype Trafficserver_plugins.plugins_lns)
  let _ = print_endline ""

  let pluginstring = "/foo/bar.so I am an \"arg\" # this is the foobar plugin
"

  test Trafficserver_plugins.plugins_lns get pluginstring = 
	{ "1" = "/foo/bar.so"
		{ "args" = "I am an \"arg\"" }
		{ "#comment" = "this is the foobar plugin" }
	}

