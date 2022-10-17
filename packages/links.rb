require 'package'

class Links < Package
  description 'Links is a lynx-like text WWW browser with tables and frames.'
  homepage 'http://links.twibright.com/'
  version '2.27'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://links.twibright.com/download/links-2.27.tar.bz2'
  source_sha256 'd8ddcbfcede7cdde80abeb0a236358f57fa6beb2bcf92e109624e9b896f9ebb4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/links/2.27_armv7l/links-2.27-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/links/2.27_armv7l/links-2.27-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/links/2.27_i686/links-2.27-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/links/2.27_x86_64/links-2.27-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'abb63d5f2a6dabba050e73e733281baf2c69520e73eb0559083098faf5d25a9b',
     armv7l: 'abb63d5f2a6dabba050e73e733281baf2c69520e73eb0559083098faf5d25a9b',
       i686: 'e355a25d62cec326c8f5f607c5b42936bf5040763f4bf5fcb6f4af664caa4a91',
     x86_64: '57633c8a05445f880b8f0c04fc7847ba8ab6ffc4716ec56757772908ef7bbe82'
  })

  depends_on 'bz2'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'lzma'
  depends_on 'openssl'
  depends_on 'zlibpkg'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
