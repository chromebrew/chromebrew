require 'package'

class Libxcursor < Package
  description 'X.org X Cursor management library'
  homepage 'http://www.x.org'
  version '1.2.1'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXcursor-#{version}.tar.gz"
  source_sha256 '77f96b9ad0a3c422cfa826afabaf1e02b9bfbfc8908c5fa1a45094faad074b98'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcursor/1.2.1_armv7l/libxcursor-1.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcursor/1.2.1_armv7l/libxcursor-1.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcursor/1.2.1_i686/libxcursor-1.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcursor/1.2.1_x86_64/libxcursor-1.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a97308abd1cfddffb54a08bbfd1018ec8d33a139e1cace109815a0056889369a',
     armv7l: 'a97308abd1cfddffb54a08bbfd1018ec8d33a139e1cace109815a0056889369a',
       i686: 'd6bd0e572055c716285f5eb5e1ba4726526424dccf18dfe16a285157fe170f7c',
     x86_64: 'c107c34d8e95d54f6552dd17c105f062a1d27016421db5628298c118bf992708'
  })

  depends_on 'libxrender'
  depends_on 'libxfixes'
  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
