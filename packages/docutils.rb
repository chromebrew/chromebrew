require 'package'

class Docutils < Package
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version '0.14'
  source_url 'https://prdownloads.sourceforge.net/project/docutils/docutils/0.14/docutils-0.14.tar.gz'
  source_sha256 '51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docutils-0.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docutils-0.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docutils-0.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docutils-0.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b981eecf82f7dd1bbbd29d2467a632b8b400f1c64efa5dda9d497fe99b2af98c',
     armv7l: 'b981eecf82f7dd1bbbd29d2467a632b8b400f1c64efa5dda9d497fe99b2af98c',
       i686: '6711f08e339c595025819c590f0e154a60fd625f039d561a091d1482a1654682',
     x86_64: 'd551a697f37dc6d03b77d2740637c3c1c36a0fa74fbac813e5dcb16745f4cd32',
  })

  depends_on 'python3'

  def self.install
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
