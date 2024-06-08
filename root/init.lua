local address = computer.getBootAddress()
local kernel_path = "/boot/00_kernel.lua"
local gpu = component.proxy(component.list("gpu")())

local function loadfile(file)
    local handle, err = component.invoke(address, "open", file)
    if not handle then
        return nil, err
    end

    local data = component.invoke(address, "read", handle, math.huge)
    component.invoke(address, "close", handle)

    return load(data)
end

local function dofile(file)
    local chunk, err = loadfile(file)
    if not chunk then
        return nil, err
    end

    return chunk()
end

local ok, err = pcall(dofile(kernel_path))
if not ok then
    gpu.set(1,1,err)
end

while true do
    local signal = computer.pullSignal()
enda