include("character.jl")
include("face.jl")

type Text
    characters::Array{Character,1}

    function Text(shaderPrograms::ShaderPrograms, face::Face, text::AbstractString)
        self = new([])
        for ch in text
            push!(self.characters, Character(shaderPrograms, face, ch))
        end
        return self
    end
end

function draw(self::Text, previousModelview::Modelview)
    modelview = copy(previousModelview)
    for ch in self.characters
        draw(ch, modelview)
    end
end
