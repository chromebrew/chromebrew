require 'package'

class Zathura_poppler_pdf < Package
  description 'The zathura_poppler_pdf plugin adds PDF support to zathura by using the poppler rendering engine.'
  homepage 'https://pwmt.org/projects/zathura-pdf-poppler/'
  version '0.3.0'
  source_url 'https://pwmt.org/projects/zathura-pdf-poppler/download/zathura-pdf-poppler-0.3.0.tar.xz'
  source_sha256 'd5cc3a7dae49471b85b503bbb9049c6f8d10903f4a611d721a2e0fefe726d4ed'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'zathura'
  depends_on 'poppler'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
