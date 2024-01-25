require 'package'

class Jpegoptim < Package
  description 'Utility to optimize/compress JPEG files'
  homepage 'https://github.com/tjko/jpegoptim'
  version '1.5.0'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/tjko/jpegoptim/archive/v1.5.0.tar.gz'
  source_sha256 '67b0feba73fd72f0bd383f25bf84149a73378d34c0c25bc0b9b25b0264d85824'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4decc886ec846db2b6c730ddac7593c806fdad9f271dfdd91f164a3f167f751',
     armv7l: 'd4decc886ec846db2b6c730ddac7593c806fdad9f271dfdd91f164a3f167f751',
       i686: '8c944bed8ae566930095f00fcf73e9c6dd26e49f00162a46e5574050227df70b',
     x86_64: '0954751ef6aada53613c24fba136c5a2257c64338ad972e6bc07597041d0bddc'
  })

  depends_on 'libjpeg'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
    system 'make', 'strip'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
