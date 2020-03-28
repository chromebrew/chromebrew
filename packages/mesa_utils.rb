require 'package'

class Mesa_utils< Package
  description 'Open-source implementation of the OpenGL specification - Provides tools such as glxinfo, glxgears'
  homepage 'https://www.mesa3d.org'
  version '8.4.0'
  source_url 'https://gitlab.freedesktop.org/mesa/demos/-/archive/mesa-demos-8.4.0/demos-mesa-demos-8.4.0.tar.bz2'
  source_sha256 '84338ce936fa110232a62bcd36c7c2c8710c4a280e9a81c4d10d06f6c2506b7d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'mesa'
  depends_on 'glew'

  def self.build
    system "./autogen.sh"
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
