include("modelview.jl")

type Triangle
    angle :: GLfloat
    vao :: GLuint
    vbo :: GLuint
    program :: GLuint

    function Triangle(shaderPrograms :: ShaderPrograms)
        vertices = [
            0.0f0, 0.2f0,
            0.5f0, -0.5f0,
            -0.5f0, -0.5f0
        ]

        self = new(0)

        vao = Array(GLuint, 1)
        glGenVertexArrays(1, vao)
        self.vao = vao[1]
        assert(self.vao != 0)
        glBindVertexArray(self.vao)

        vbo = Array(GLuint, 1)
        glGenBuffers(1, vbo)
        self.vbo = vbo[1]
        assert(self.vbo != 0)
        glBindBuffer(GL_ARRAY_BUFFER, self.vbo)
        glBufferData(GL_ARRAY_BUFFER, size(vertices, 1) * sizeof(GLfloat), vertices, GL_STATIC_DRAW)

        self.program = shaderPrograms.simple
        glUseProgram(self.program)

        posAttrib = glGetAttribLocation(self.program, "position")
        assert(posAttrib >= 0)
        glVertexAttribPointer(posAttrib, 2, GL_FLOAT, GL_FALSE, 0, C_NULL)
        glEnableVertexAttribArray(posAttrib)

        uniColor = glGetUniformLocation(self.program, "triangleColor")
        assert(uniColor != -1)
        glUniform3f(uniColor, 1, 1, 0)

        return self
    end
end

function step(self::Triangle)
    self.angle += 0.05
end

function draw(self::Triangle, previousModelview::Modelview)
    modelview = copy(previousModelview)
    rotate(modelview, self.angle, [0, 1, 0.5f0])
    setUniform(modelview)

    glBindVertexArray(self.vao)
    glBindBuffer(GL_ARRAY_BUFFER, self.vbo)
    glUseProgram(self.program)
    glDrawArrays(GL_TRIANGLES, 0, 3)
end
