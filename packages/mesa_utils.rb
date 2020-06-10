require 'package'

class Mesa_utils< Package
  description 'Open-source implementation of the OpenGL specification - Provides tools such as glxinfo, glxgears'
  homepage 'https://www.mesa3d.org'
  version '8.4.0'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/demos/mesa-demos-8.4.0.tar.bz2'
  source_sha256 '01e99c94a0184e63e796728af89bfac559795fb2a0d6f506fa900455ca5fff7d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa_utils-8.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa_utils-8.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa_utils-8.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa_utils-8.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '441d8cb0093be26118691d3f134c2fedbefea9f4b9189672d14e1954259fae34',
     armv7l: '441d8cb0093be26118691d3f134c2fedbefea9f4b9189672d14e1954259fae34',
       i686: '9154f4f5f1f116ebe2c6b4d601689b6651314aaca776d9e7a2c0a011dd677bf2',
     x86_64: '2c8612ab1600e7e68a3e0f57ce59a56637c2f5ea04312dbdce172d9aeece593e',
  })

  depends_on 'mesa'
  depends_on 'glew'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
