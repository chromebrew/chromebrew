require 'package'

class Faad2 < Package
  description 'Freeware Advanced Audio (AAC) Decoder'
  homepage 'https://faac.sourceforge.net/'
  version '2.10.1'
  license 'GPL2 custom'
  compatibility 'all'
  source_url 'https://github.com/knik0/faad2/archive/2.10.1.tar.gz'
  source_sha256 '4c16c71295ca0cbf7c3dfe98eb11d8fa8d0ac3042e41604cfd6cc11a408cf264'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/faad2/2.10.1_armv7l/faad2-2.10.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/faad2/2.10.1_armv7l/faad2-2.10.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/faad2/2.10.1_i686/faad2-2.10.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/faad2/2.10.1_x86_64/faad2-2.10.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '389a358f4514844f9ba7d50d7472b34e403707fb195dd8075e6dd2d0c3178d50',
     armv7l: '389a358f4514844f9ba7d50d7472b34e403707fb195dd8075e6dd2d0c3178d50',
       i686: 'b0ca855b9f06e9bd4f3d5ec04877605f93b3a2daac4e930235bb10e2996759a8',
     x86_64: '9c9290c676d3c77a86b0f45e1b4cdd6aa32cd75c149c260a30e281cdd58870ec'
  })

  depends_on 'glibc'

  def self.build
    system './bootstrap'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
