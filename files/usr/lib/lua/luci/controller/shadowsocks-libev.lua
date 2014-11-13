--[[
LuCI - Lua Configuration Interface

Copyright 2014 Richad Jia <info@xiumu.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

module("luci.controller.shadowsocks-libev", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/shadowsocks") then
		return
	end

	local page

	entry({"admin", "services", "shadowsocks"}, cbi("shadowsocks"), _("shadowsocks"), 1).dependent = true

end
