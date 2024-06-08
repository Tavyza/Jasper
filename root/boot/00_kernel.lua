while true do
    local signal = computer.pullSignal()
    gpu.set(1,1,signal)
end