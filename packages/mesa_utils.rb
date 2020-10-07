require 'package'

class Mesa_utils< Package
  description 'Open-source implementation of the OpenGL specification - Provides tools such as glxinfo, glxgears'
  homepage 'https://www.mesa3d.org'
  version '8.4.0-1'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/demos/mesa-demos-8.4.0.tar.bz2'
  source_sha256 '01e99c94a0184e63e796728af89bfac559795fb2a0d6f506fa900455ca5fff7d'

  depends_on 'mesa'
  depends_on 'glew'

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
