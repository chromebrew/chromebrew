require 'package'

class Mesa_utils< Package
  description 'Open-source implementation of the OpenGL specification - Provides tools such as glxinfo, glxgears'
  homepage 'https://www.mesa3d.org'
  version '8.4.0-1'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/demos/mesa-demos-8.4.0.tar.bz2'
  source_sha256 '01e99c94a0184e63e796728af89bfac559795fb2a0d6f506fa900455ca5fff7d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa_utils-8.4.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa_utils-8.4.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa_utils-8.4.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa_utils-8.4.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '79f7aa0c1e8b69ab4b12045e2362ee75c98e700e01a3808a74c0f7d6aef4f74b',
     armv7l: '79f7aa0c1e8b69ab4b12045e2362ee75c98e700e01a3808a74c0f7d6aef4f74b',
       i686: '03db825ab275db23372dca3e76cb9676f4de8b0be232f96a15f5c500ee7b438a',
     x86_64: 'c9f1bd525f7ace061488cc1780928f9e6face4509210bd5c348ad60dee2c97c9',
  })

  depends_on 'mesa'
  depends_on 'glew'
  depends_on 'freeglut'

  def self.build
    #ENV['CFLAGS'] = "-fuse-ld=lld"
    #ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
