require 'package'

class Rlottie < Package
  description 'rlottie is a platform independent standalone c++ library for rendering vector based animations and art in realtime.'
  homepage 'https://github.com/Samsung/rlottie'
  version '0.2'
  compatibility 'all'
  source_url 'https://github.com/Samsung/rlottie/archive/v0.2.tar.gz'
  source_sha256 '030ccbc270f144b4f3519fb3b86e20dd79fb48d5d55e57f950f12bab9b65216a'

  def self.build
    system "mkdir build"
    Dir.chdir "build" do
      system "cmake -G 'Unix Makefiles' \ 
            #{CREW_CMAKE_OPTIONS} .." #I'd like to use ninja as it builds faster, but I couldn't figure out the install part.
      system "make"
    end
  end

  def self.install
    Dir.chdir "build" do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      FileUtils.mv "#{CREW_DEST_DIR}/usr/lib", "#{CREW_DEST_PREFIX}/#{ARCH_LIB}"
    end
  end
end
