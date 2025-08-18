require 'package'

class Libxcursor < Package
  description 'X.org X Cursor management library'
  homepage 'https://www.x.org/wiki/'
  version '1.2.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.x.org/archive/individual/lib/libXcursor-#{version}.tar.gz"
  source_sha256 '74e72da27e61cc2cfd2e267c14f500ea47775850048ee0b00362a55c9b60ee9b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a97308abd1cfddffb54a08bbfd1018ec8d33a139e1cace109815a0056889369a',
     armv7l: 'a97308abd1cfddffb54a08bbfd1018ec8d33a139e1cace109815a0056889369a',
     x86_64: 'c107c34d8e95d54f6552dd17c105f062a1d27016421db5628298c118bf992708'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxfixes'
  depends_on 'libxrender'

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
