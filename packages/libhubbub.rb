require 'package'

class Libhubbub < Package
  description 'HTML5 compliant parsing library, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.3.7'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libhubbub-0.3.7-src.tar.gz'
  source_sha256 '9e7ae253e6c9069e757eb9ad4e4846f38b4db52c0ca0151446a9fa4a977735b6'

  depends_on 'libxslt'
  depends_on 'jsonc'
  depends_on 'libparserutils'

  def self.build
   system "make -j#{CREW_NPROC} PREFIX=#{CREW_PREFIX}"
  end
  def self.install
   system "make -j#{CREW_NPROC} DESTDIR=#{CREW_DEST_DIR} install PREFIX=#{CREW_PREFIX}"
  end
end
