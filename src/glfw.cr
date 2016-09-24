require "lib_glfw3"
require "./glfw/*"

module GLFW
  alias WindowLike = Window | LibGLFW3::Window
  alias MonitorLike = LibGLFW3::Monitor
  alias GammaRamp = LibGLFW3::GammaRamp
  alias VideoMode = LibGLFW3::VidMode
  alias Cursor = LibGLFW3::Cursor

  if LibGLFW3.init == 0
    abort "*** ERROR: failed to initialize GLFW (glfwInit returned 0) ***"
  end

  at_exit do |_code|
    LibGLFW3.terminate
  end

  error_callback = ->(error : Int32, description : Int8*) {
    desc_str = String.new(description.as(UInt8*))
    STDERR.puts "*** ERROR: #{desc_str} (#{error}) ***"
  }
  LibGLFW3.setErrorCallback(error_callback)

  def self.version : { major: Int32, minor: Int32, rev: Int32 }
    LibGLFW3.getVersion(out major, out minor, out rev)
    { major: major, minor: minor, rev: rev }
  end

  def self.version_string : String
    String.new(LibGLFW3.getVersionString.as(UInt8*))
  end

  def self.poll_for_events : Nil
    LibGLFW3.pollEvents()
  end

  def self.wait_forevents : Nil
    LibGLFW3.waitEvents()
  end

  def self.post_empty_event : Nil
    LibGLFW3.postEmptyEvent()
  end

  def self.time
    LibGLFW3.getTime()
  end

  def self.time=(value : Float64)
    LibGLFW3.setTime(value)
    value
  end

  # TODO: joystick methods

  def self.swap_interval=(interval : Int32)
    LibGLFW3.swapInterval(interval)
    interval
  end

  def self.extension_supported?(extension : String) : Bool
    LibGLFW3.extensionSupported(extension) != 0
  end

  # TODO: better API for this?
  def self.get_proc_address(procname : String)
    LibGLFW3.getProcAddress(procname)
  end
end
