require 'package'

class Glfw < Package                 # The first character of the class name must be upper case
  description 'GLFW is a multi-platform library for OpenGL, OpenGL ES, Vulkan, window and input '
  homepage 'http://www.glfw.org/'
  version '3.2.1'
  source_url 'https://github.com/glfw/glfw/archive/3.2.1.zip'
  source_sha256 '0c623f65a129c424d0fa45591694fde3719ad4a0955d4835182fda71b255446f'   # Use the command "sha256sum"

  depends_on 'cmake' => :build      # packages with "=> :build" are only required if you're building from source 

  def self.build                   # the steps required to build the package
    case ARCH
    with 'x86_64'
      system "cmake","-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}", "-DCMAKE_LIB_SUFFIX=64"
    else
      system "cmake","-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}"
    end
    system "make"
  end

  def self.install                 # the steps required to install the package
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check                   # the steps required to check if the package was built ok
    system "make", "check"
  end
end
