require "lib_glfw3"

module GLFW
  struct Window
    @handle : LibGLFW3::Window

    def initialize(@handle)
    end

    def initialize(width, height, title, monitor : MonitorLike? = nil, share : WindowLike? = nil, hints = {} of Int32 => Int32)
      Window.hints = hints
      @handle = Window.create(width, height, title, monitor, share)
    end

    def initialize(width, height, title, hints)
      Window.hints = hints
      @handle = Window.create(width, height, title, nil, nil)
    end

    def initialize(width, height, title, monitor : MonitorLike?, hints)
      Window.hints = hints
      @handle = Window.create(width, height, title, monitor, nil)
    end

    def initialize(width, height, title, share : WindowLike?, hints)
      Window.hints = hints
      @handle = Window.create(width, height, title, nil, share)
    end

    def destroy : Nil
      LibGLFW3.destroyWindow(@handle)
    end

    def finalize
      self.destroy
    end

    def should_close? : Bool
      LibGLFW3.windowShouldClose(@handle) != 0
    end

    def should_close=(value : Bool)
      LibGLFW3.setWindowShouldClose(@handle, value ? 1 : 0)
      value
    end

    def close : Nil
      self.should_close = true
    end

    def dont_close : Nil
      self.should_close = false
    end

    def title=(str : String)
      LibGLFW3.setWindowTitle(@handle, str)
      str
    end

    def position
      LibGLFW3.getWindowPos(@handle, out xpos, out ypos)
      { x: xpos, y: ypos }
    end

    def position=(value : { x: Int32, y: Int32 })
      LibGLFW3.setWindowPos(@handle, value[:x], value[:y])
      value
    end

    def size
      LibGLFW3.getWindowSize(@handle, out width, out height)
      { height: height, width: width }
    end

    def size=(value : { width: Int32, height: Int32 })
      LibGLFW3.setWindowSize(@handle, value[:width], value[:height])
      value
    end

    def framebuffer_size
      LibGLFW3.getFramebufferSize(@handle, out width, out height)
      { height: height, width: width }
    end

    def frame_size
      LibGLFW3.getWindowFrameSize(@handle, out width, out height)
      { height: height, width: width }
    end

    def iconify
      LibGLFW3.iconifyWindow(@handle)
    end

    def restore
      LibGLFW3.restoreWindow(@handle)
    end

    def show
      LibGLFW3.showWindow(@handle)
    end

    def hide
      LibGLFW3.hideWindow(@hande)
    end

    def monitor
      Monitor.new(LibGLFW3.getWindowMonitor(@handle))
    end

    # TODO: better API for attributes?
    def attribute(key)
      LibGLFW3.getWindowAttrib(@handle, key)
    end

    # TODO: useful? dangerous? better API? Use for something else?
    def user_pointer : Void*
      LibGLFW.getWindowUserPointer(@handle)
    end

    def user_pointer=(ptr : Void*)
      LibGLFW3.setWindowUserPointer(@handle, ptr)
      ptr
    end

    # TODO: callbacks

    # TODO: better API for input modes?
    def get_input_mode(mode : Int32)
      LibGLFW3.getInputMode(@handle, mode)
    end

    def set_input_mode(mode : Int32, value : Int32)
      LibGLFW3.setInputMode(@handle, mode, value)
    end

    # TODO: better API for key pressed/released?
    def get_key(key : Int32)
      LibGLFW3.getKey(@handle, key)
    end

    # TODO: better API for mouse buttons?
    def get_mouse_button(button : Int32)
      LibGLFW3.getMouseButton(@handle, button)
    end

    def cursor_position
      LibGLFW3.getCursorPos(@handle, out xpos, out ypos)
      { x: xpos, y: ypos }
    end

    def cursor_position=(value : { x: Float64, y: Float64 })
      LibGLFW3.setCursorPos(@handle, value[:x], value[:y])
      value
    end

    def cursor=(value : Cursor)
      LibGLFW3.setCursor(@handle, value)
      value
    end

    def clipboard : String
      String.new(LibGLFW3.getClipboardString(@handle).as(UInt8*))
    end

    def clipboard=(str : String)
      LibGLFW3.setClipboardString(@handle, str)
      str
    end

    def make_current : Nil
      LibGLFW3.makeContextCurrent(@handle)
    end

    def swap_buffers : Nil
      LibGLFW3.swapBuffers(@handle)
    end

    def to_unsafe
      @handle
    end

    def ==(other : Window)
      @handle == other.to_unsafe
    end

    def ==(other : LibGLFW3::Window)
      @handle == other
    end

    def self.create(width, height, title, monitor = nil, share = nil) : LibGLFW3::Window
      handle = LibGLFW3.createWindow(width, height, title, monitor, share)
      raise "Error creating window" if !handle
      handle
    end

    def self.hints=(hints_map : Hash(Int32, Int32))
      self.hints = nil
      hints_map.each do |k, v|
        LibGLFW3.windowHint(k, v)
      end
    end

    def self.hints=(hints_map : Nil) : Nil
      LibGLFW3.defaultWindowHints()
    end

    def self.current
      new(LibGLFW3.getCurrentContext())
    end
  end
end
