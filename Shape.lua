--演示类的写法，一个文件可以声明多个类，父类到子类要从上往下写

--声明一个基类，表示图形的形状
Shape = {}
--声明成员属性
Shape.name = "形状"
--声明成员方法
--获取该形状的周长
function Shape:getCircumference()
end
--获取该形状的面积
function Shape:getArea()
end

function Shape:toString()
    return string.format("%s的周长是%.2f，面积是%.2f", self.name, self:getCircumference(), self:getArea())
end

--声明一个子类Rect表示矩形，继承Shape
Rect = {}
Rect.name = "矩形"
--矩形的宽和高
Rect.width = 1
Rect.height = 1
--声明一个初始化方法
function Rect:init(width, height)
    self.width = width
    self.height = height
end
--重写父类的方法
function Rect:getCircumference()
    return 2 * (self.width + self.height)
end

function Rect:getArea()
    return self.width * self.height
end
--设置继承关系，需要注意的是：必须在声明完所有属性、方法后设置继承，否则声明属性方法的时候实际上在索引赋值父类的属性、方法
inherit(Rect, Shape)


--声明一个子类Circle表示圆形，继承Shape
Circle = {}
Circle.name = "圆形"
--圆的半径
Circle.radius = 1
--声明一个初始化方法
function Circle:init(name, radius)
    self.name = name
    self.radius = radius
end
--重写父类的方法
function Circle:getCircumference()
    return 2 * math.pi * self.radius
end

function Circle:getArea()
    return math.pi * self.radius * self.radius
end

function Circle:toString()
    return string.format("%s的半径是%.2f，周长是%.2f，面积是%.2f", self.name, self.radius, self:getCircumference(), self:getArea())
end

--设置继承关系，需要注意的是：必须在声明完所有属性、方法后设置继承，否则声明属性方法的时候实际上在索引赋值父类的属性、方法
inherit(Circle, Shape)
