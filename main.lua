local DState = require "DState"
local NDState = require "NDState"
local Runner = require "Runner"
local Reducer = require "Reducer"

---------------
local q0 = NDState:new("q0", false)
local q1 = NDState:new("q1", false)
local q2 = NDState:new("q2", true)

q0:add('0', q0)
q0:add('0', q1)
q0:add('1', q0)
q1:add('1', q2)
-------------

local q0 = Reducer.reduce(q0, {"0", "1"})
Runner.runDFA(q0, "0001", "[01]")