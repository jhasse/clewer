const OPENGL_MAJOR = 3
const OPENGL_MINOR = 0

const OpenGLver="$OPENGL_MAJOR.$OPENGL_MINOR"
using ModernGL

import ModernGL.getprocaddress

function getprocaddress(name::ASCIIString)
    GLFW.GetProcAddress(name)
end