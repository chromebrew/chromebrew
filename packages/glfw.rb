require 'package'

class Glfw < Package                 # The first character of the class name must be upper case
  description 'GLFW is an Open Source, multi-platform library for OpenGL, OpenGL ES and Vulkan development on the desktop. It provides a simple API for creating windows, contexts and surfaces, receiving input and events.'
  homepage 'http://www.glfw.org/'
  version '3.2.1-1'
  compatibility 'all'
  source_url 'https://github.com/glfw/glfw/archive/3.2.1.zip'
  source_sha256 '0c623f65a129c424d0fa45591694fde3719ad4a0955d4835182fda71b255446f'   # Use the command "sha256sum"

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glfw-3.2.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glfw-3.2.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glfw-3.2.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glfw-3.2.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2a549383779eeab73503f189cc35249bf05e92fe4fdc69284501d1ab04b3b296',
     armv7l: '2a549383779eeab73503f189cc35249bf05e92fe4fdc69284501d1ab04b3b296',
       i686: '0792cf89605743251dcc304cefd2596ad1ed61fb3f72967c14119bfba0e22fcb',
     x86_64: '41f70d1903f01a11ca658ef4460d6c2af09be0a3596e12bf75b663164107a84b',
  })

  depends_on 'cmake' => :build      # packages with "=> :build" are only required if you're building from source 
  depends_on 'sommelier' => :build

  def self.build                   # the steps required to build the package
    case ARCH
    when 'x86_64'
      system "cmake", "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}", "-DLIB_SUFFIX=64"
    else
      system "cmake", "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}"
    end
    system 'make'
  end

  def self.install                 # the steps required to install the package
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
