# GLFW for Crystal

Idiomatic Crystal API to libglfw. This shard provides an OOP wrapper around [libglfw3](https://github.com/jellymann/crystal_lib_glfw3), to make it easier to write GLFW apps in Crystal.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  glfw:
    github: jellymann/crystal_glfw
```


## Usage

Example code for creating a window (tested on macOS 10.11)
```crystal
require "glfw"

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
```


## Development

To run the specs

```
crystal spec
```


## Contributing

1. Fork it ( https://github.com/jellymann/crystal_glfw/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jellymann](https://github.com/jellymann) Daniel Smith - creator, maintainer
