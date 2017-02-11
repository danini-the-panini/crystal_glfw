require "lib_glfw3"

module GLFW
  class Monitor
    def initialize(@handle : LibGLFW3::Monitor)
    end

    def position
      LibGLFW3.getMonitorPos(@handle, out xpos, out ypos)
      { x: xpos, y: ypos }
    end

    def physical_size
      LibGLFW3.getMonitorPhysicalSize(@handle, out widthMM, out heightMM)
      { width: widthMM, height: heightMM }
    end

    def name : String
      String.new(LibGLFW3.getMonitorName(@handle).as(UInt8*))
    end

    #TODO callback

    def video_modes : Array(VideoMode)
      modes = LibGLFW3.getVideoModes(@handle, out count)
      ary = Array(VideoMode).new(count)
      count.times do |i|
        ary[i] = modes[i]
      end
    end

    def video_mode : VideoMode
      LibGLFW3.getVideoMode(@monitor)[0]
    end

    def gamma=(g : GammaRamp)
      LibGLFW3.setGamma(@handle, g)
      g
    end

    def gamma_ramp : GammaRamp
      LibGLFW3.getGammaRamp(@handle)
    end

    def gamma_ramp=(ramp : GammaRamp)
      LibGLFW3.setGammaRamp(@handle, ramp)
      ramp
    end

    def to_unsafe
      @handle
    end

    def self.all
      monitors = LibGLFW3.getMonitors(out count)
      count.times.map { |i| new(monitors[i]) }
    end

    def self.primary
      new(LibGLFW3.getPrimaryMonitor())
    end
  end
end
