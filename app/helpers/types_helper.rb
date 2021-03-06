module TypesHelper
    def type_link(type)
        link_to type_badge(type.name, type.color), type
    end
    
    def type_badge(name, color)
        raw "<span style='background-color: #{color}' class='badge'>#{name}</span>"
    end
end
