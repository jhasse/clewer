#version 130

in vec2 Texcoord;

out vec4 outColor;

uniform sampler2D tex;

void main() {
    outColor = vec4(1.0, 1.0, 1.0, texture(tex, Texcoord).r);
}
