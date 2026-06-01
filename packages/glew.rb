require 'package'

class Glew < Package
  description 'GLEW provides efficient run-time mechanisms for determining which OpenGL extensions are supported on the target platform'
  homepage 'https://glew.sourceforge.net/'
  version '2.3.1'
  license 'BSD and MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/glew/glew/#{version}/glew-#{version}.tgz"
  source_sha256 'b64790f94b926acd7e8f84c5d6000a86cb43967bd1e688b03089079799c9e889'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b30d6ac674aa194df1fb3b1eacc4242a75fd4918c51595a152c289fb3b4c3b92',
     armv7l: 'b30d6ac674aa194df1fb3b1eacc4242a75fd4918c51595a152c289fb3b4c3b92',
     x86_64: '901ed95975a37d1e2560c991db5624ef6917fce46d13c873bf8088e2b38401c6'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libx11' => :library
  depends_on 'mesa' => :library

  def self.patch
    # The library path is hardcoded.
    if ARCH.eql?('x86_64')
      system "sed -i 's,/usr/lib64,#{CREW_LIB_PREFIX},' config/Makefile.linux"
    else
      system "sed -i 's,/usr/lib,#{CREW_LIB_PREFIX},' config/Makefile.linux"
    end
  end

  def self.build
    system 'make', "GLEW_PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", "PKGDIR=#{CREW_LIB_PREFIX}/pkgconfig"
  end

  def self.install
    system 'make', "GLEW_PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_LIB_PREFIX}", "PKGDIR=#{CREW_LIB_PREFIX}/pkgconfig", 'install'
  end
end
