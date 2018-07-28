--注意：因为Lua是脚本语言，从上到下加载，所以要先导入OOLuaSystem，再导入自定义的类
require("OOLuaSystem")
require("Shape")


--继承、多态
rect1 = new(Rect)
rect1:init(2.5, 2.5)

rect2 = new(Rect)
rect2:init(4, 4)

circleA = new(Circle)
circleA:init("圆A", 1)

circleB = new(Circle)
circleB:init("圆B", 2)

print(rect1:toString()) 
print(rect2:toString())
print(circleA:toString())
print(circleB:toString())
--[[
输出如下：    
矩形的周长是10.00，面积是6.25
矩形的周长是16.00，面积是16.00
圆A的半径是1.00，周长是6.28，面积是3.14
圆B的半径是2.00，周长是12.57，面积是12.57
]]


--索引不存在的属性时抛出异常，下面故意写错属性名
--print(circleA.nama)       --抛出异常“索引不到该成员: nama”
--circleA.radios = 1        --抛出异常“输出索引赋值时索引不到该成员: radios”


--创建属性为只读的对象，下面故意修改只读的属性
-- circleC = createReadOnlyObject(circleA)
-- circleC.radius = 10      --抛出异常“只读属性不可修改:radius”