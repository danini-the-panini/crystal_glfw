require "../src/glfw"

hints = {
  LibGLFW3::OPENGL_PROFILE => LibGLFW3::OPENGL_CORE_PROFILE,
  LibGLFW3::OPENGL_FORWARD_COMPAT => 1,
  LibGLFW3::CONTEXT_VERSION_MAJOR => 3,
  LibGLFW3::CONTEXT_VERSION_MINOR => 3
}

window = GLFW::Window.new(800, 600, "Hello, Crystal!", hints)

window.make_current

GLFW.swap_interval = 1

until window.should_close?
  window.swap_buffers
  GLFW.poll_for_events
end
