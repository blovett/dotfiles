hyper = { "alt" }

loggerInfo = hs.logger.new("My Settings", "info")

require 'caffeine'
require 'window-management'

function sleep(n)
	os.execute("sleep " .. tonumber(n))
end

function lock_system()
	sleep(1)
	hs.caffeinate.startScreensaver()
end

-- Lock System
hs.hotkey.bind(hyper, 'Q', 'Lock system', function() lock_system() end)
-- Sleep system
-- hs.hotkey.bind(hyper, 'S', 'Put system to sleep',function() hs.caffeinate.systemSleep() end)
