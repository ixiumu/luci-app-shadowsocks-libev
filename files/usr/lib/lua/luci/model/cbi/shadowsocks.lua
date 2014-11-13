--[[
LuCI - Lua Configuration Interface

Copyright 2014 朽木 <http://www.xiumu.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

m = Map("shadowsocks", translate("shadowsocks"),
	translate("A fast tunnel proxy that helps you bypass firewalls."))

s = m:section(NamedSection, "config", "shadowsocks", "服务器设置")
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enable", translate("Enable"))
o.rmempty=false

function o.cfgvalue(self, section)
	return luci.sys.init.enabled("shadowsocks") and self.enabled or self.disabled
end

function o.write(self, section, value)
	if value == "1" then
		luci.sys.call("/etc/init.d/shadowsocks enable >/dev/null")
		luci.sys.call("/etc/init.d/shadowsocks start >/dev/null")
	else
		luci.sys.call("/etc/init.d/shadowsocks stop >/dev/null")
		luci.sys.call("/etc/init.d/shadowsocks disable >/dev/null")
	end
	Flag.write(self, section, value)
end

o = s:option(Value, "server", translate("服务器"))
o.rmempty=true
o.placeholder = "127.0.0.1"

o = s:option(Value, "server_port", translate("Port"))
o.datatype = "port"
o.rmempty = true
o.placeholder = 1080


s:option(Value, "password", translate("Password")).password = true

o = s:option(ListValue, "method", "加密算法")
o.default="aes-256-cfb"
o:value("table")
o:value("rc4")
o:value("rc4-md5")
o:value("aes-128-cfb")
o:value("aes-192-cfb")
o:value("aes-256-cfb")
o:value("bf-cfb")
o:value("camellia-128-cfb")
o:value("camellia-192-cfb")
o:value("camellia-256-cfb")
o:value("cast5-cfb")
o:value("des-cfb")
o:value("idea-cfb")
o:value("rc2-cfb")
o:value("seed-cfb")

o = s:option(Value, "timeout", "超时")
o.datatype = "uinteger"
o.default = "600"

s:option(Flag, "fast_open", translate("TFO"),
	translate("服务器Linux内核大于3.7时可以开启TCP Fast Open。"))

s:option(Value, "addnconf", translate("配置文件"),
	translate("启用自定义配置文件将覆盖上面的设置。"))

s = m:section(TypedSection, "shadowsocks", "本地设置")
s.addremove = false
s.anonymous = true

o = s:option(Value, "local_port", "ss-local 端口",
	translate("不填写为不启用ss-local。"))
o.datatype = "port"
o.rmempty = true
o.placeholder = 8888

o = s:option(Value, "redir_port", "ss-redir 端口",
	translate("不填写为不启用ss-redir。"))
o.datatype = "port"
o.rmempty = true
o.placeholder = 1080

return m