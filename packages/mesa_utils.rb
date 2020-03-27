require 'package'

class Mesa_utils< Package
  description 'Open-source implementation of the OpenGL specification - Provides tools such as glxinfo, glxgears'
  homepage 'https://www.mesa3d.org'
  version '8.4.0'
  source_url 'ftp://ftp.freedesktop.org/pub/mesa/demos/mesa-demos-8.4.0.tar.bz2'
  source_sha256 '01e99c94a0184e63e796728af89bfac559795fb2a0d6f506fa900455ca5fff7d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'mesa'
  depends_on 'glew'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
