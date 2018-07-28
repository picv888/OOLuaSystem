--深复制任意数据类型，使用旧表的元表给新数据设置元表
clone = function(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local newObject = {}
        lookup_table[object] = newObject
        for key, value in pairs(object) do
            newObject[_copy(key)] = _copy(value)
        end
        return setmetatable(newObject, getmetatable(object))
    end
    return _copy(object)
end

--继承，father为nil则使元表中的元方法抛出异常
inherit = function(son, father)
    if father == nil then
        local meta = getmetatable(son)
        if meta ~= nil then
            meta.__index = function(table, key)
                error("索引不到该成员: " .. key)
            end
            meta.__newindex = function(table, key, value)
                error("索引赋值时索引不到该成员: " .. key)
            end
        else
            setmetatable(
                son,
                {
                    __index = function(table, key)
                        error("索引不到该成员: " .. key)
                    end,
                    __newindex = function(table, key, value)
                        error("索引赋值时索引不到该成员: " .. key)
                    end
                }
            )
        end
    else
        local meta = getmetatable(son)
        if meta ~= nil then
            meta.__index = father
            meta.__newindex = father
        else
            setmetatable(
                son,
                {
                    __index = father,
                    __newindex = father
                }
            )
        end
    end
end

--获取父对象，没有则返回nil
getFather = function(son)
    local meta = getmetatable(son)
    if (meta ~= nil and meta.__index ~= nil and type(meta.__index) == "table") then
        return meta.__index
    end
    return nil
end

--使用类创建一个对象 (深复制这个类对象，并且递归深复制其父对象，递归设置继承)
new = function(classObject)
    if classObject == nil or type(classObject) ~= "table" then
        error("参数错误")
    end

    local function _copy(object)
        if type(object) ~= "table" then
            return object
        end
        local newObject = {}
        for key, value in pairs(object) do
            newObject[_copy(key)] = _copy(value)
        end
        return newObject
    end

    local function _copyFather(son, oldFather)
        local newFather = _copy(oldFather)
        inherit(son, newFather)
        if oldFather == nil then
            return
        end
        local oldGrandfather = getFather(oldFather)
        _copyFather(newFather, oldGrandfather)
    end

    local newObject = _copy(classObject)
    _copyFather(newObject, getFather(classObject))
    return newObject
end

--使用一个对象创建一个新的对象，属性访问权限变成只读，修改属性时抛出异常
createReadOnlyObject = function(obj)
    if (obj == nil or type(obj) ~= "table") then
        error("参数错误")
    end
    return setmetatable(
        {},
        {
            __index = obj,
            __newindex = function(table, key, value)
                error("只读属性不可修改:" .. key)
            end
        }
    )
end
