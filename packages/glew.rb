require 'package'

class Glew < Package
  description 'GLEW provides efficient run-time mechanisms for determining which OpenGL extensions are supported on the target platform'
  homepage 'http://glew.sourceforge.net/'
  version '2.1.0'
  source_url 'https://github.com/nigels-com/glew/releases/download/glew-2.1.0/glew-2.1.0.tgz'
  source_sha256 '04de91e7e6763039bc11940095cd9c7f880baba82196a7765f727ac05a993c95'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'mesa'

  def self.build
#    system "./configure",
#      "--prefix=#{CREW_PREFIX}",
#      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "GLEW_DEST=#{CREW_DEST_DIR}", "install"
  end
end
