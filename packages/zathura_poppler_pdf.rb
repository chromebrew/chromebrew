require 'package'

class Zathura_poppler_pdf < Package
  description 'The zathura_poppler_pdf plugin adds PDF support to zathura by using the poppler rendering engine.'
  homepage 'https://pwmt.org/projects/zathura-pdf-poppler/'
  version '0.3.0'
  compatibility 'all'
  source_url 'https://pwmt.org/projects/zathura-pdf-poppler/download/zathura-pdf-poppler-0.3.0.tar.xz'
  source_sha256 'd5cc3a7dae49471b85b503bbb9049c6f8d10903f4a611d721a2e0fefe726d4ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zathura_poppler_pdf-0.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zathura_poppler_pdf-0.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zathura_poppler_pdf-0.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zathura_poppler_pdf-0.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f0a5457aa3ed3f5eed6f602b4439967ab6957b3d1e04e7f9a9468d77713f1ea',
     armv7l: '8f0a5457aa3ed3f5eed6f602b4439967ab6957b3d1e04e7f9a9468d77713f1ea',
       i686: 'cc192c10e8188c90ca55162e60aba590e0cebe4235ee93e58a9c868115224f3f',
     x86_64: '2a45979d58fa1ca321cd4432a2591f6e6737212ebef0abb30d9e25f5b8f1b3d0',
  })

  depends_on 'poppler'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
