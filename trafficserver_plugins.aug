module Trafficserver_plugins =
  autoload plugins_xfm

  let plugins_filter = incl "/etc/trafficserver/plugin.config"

  let eol = Util.eol
  let indent = Util.indent
  let spc = Util.del_ws_spc

  let empty = Util.empty

  let args_re = /[^ \t\n#]([^\n#]*[^ \t\n#])?/
  let path_re = /[^ \t\n#]+/

  let plugin_entry = [ indent . seq "plugin" . store path_re . ( spc . [ label "args" . store args_re ] ) ? . ( eol | Util.comment_eol ) ]

  let plugins_lns = ( Util.empty | Util.comment | plugin_entry ) *

  let plugins_xfm = transform plugins_lns plugins_filter
