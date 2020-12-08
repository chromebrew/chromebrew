require 'package'

class Glfw < Package
  description 'GLFW is an Open Source, multi-platform library for OpenGL, OpenGL ES and Vulkan development on the desktop. It provides a simple API for creating windows, contexts and surfaces, receiving input and events.'
  homepage 'http://www.glfw.org/'
  version '3.3.2'
  compatibility 'all'
  source_url 'https://github.com/glfw/glfw/releases/download/3.3.2/glfw-3.3.2.zip'
  source_sha256 '08a33a512f29d7dbf78eab39bd7858576adcc95228c9efe8e4bc5f0f3261efc7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glfw-3.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glfw-3.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glfw-3.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glfw-3.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '375586eebe407a72dd6e819c236c75d45cdb6af2fb284452d92767ec0586a031',
     armv7l: '375586eebe407a72dd6e819c236c75d45cdb6af2fb284452d92767ec0586a031',
       i686: 'c52b95bd167f4b24d5b7ba78648cef228d8b35d16e95ff46db305721de5f23bd',
     x86_64: '270e70447b7d59eb1db3ed2224f2542e45b864d6d56152236dcc22ea6a85cd1d',
  })

  depends_on 'sommelier' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake #{CREW_CMAKE_OPTIONS} -DBUILD_SHARED_LIBS=ON .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
