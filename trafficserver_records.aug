module Trafficserver_records =
  autoload records_xfm

  let records_filter = incl "/etc/trafficserver/records.config"

  let eol = Util.eol
  let indent = Util.indent
  let spc = Util.del_ws_spc
  let scope_re = "CONFIG" | "PROCESS" | "NODE" | "CLUSTER" | "LOCAL" | "PLUGIN"
  let key_re = /[A-Za-z0-9_.-]+/
  let value_re = /[^ \t\n](.*[^ \t\n])?/
  let type_re = "INT" | "FLOAT" | "STRING" | "COUNTER"

  let comment = [ indent . label "#comment" . del /[#;][ \t]*/ "# "
        . store /([^ \t\n].*[^ \t\n]|[^ \t\n])/ . eol ]

  let empty = Util.empty

  let records_entry = [ [ label "scope" . store scope_re]  . spc . key key_re . spc . [ label "type" . store type_re ] . spc . store value_re . eol ]

  let records_lns = (empty | comment | records_entry ) *

  let records_xfm = transform records_lns records_filter
