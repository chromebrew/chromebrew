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
    aarch64: 'e4e1717f4e7ccfe1238fb95a1d5ba9011116be885cf383624c8eddff19eaab2e',
     armv7l: 'e4e1717f4e7ccfe1238fb95a1d5ba9011116be885cf383624c8eddff19eaab2e',
     x86_64: 'b3e25cfd65dfdbeb5c81ebacdbc7f04276e0ebcbdbab7dfb0fdf68283d56e72c'
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
