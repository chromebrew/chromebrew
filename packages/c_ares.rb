require 'package'

class C_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.17.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://c-ares.haxx.se/download/c-ares-1.17.1.tar.gz'
  source_sha256 'd73dd0f6de824afd407ce10750ea081af47eba52b8a6cb307d220131ad93fc40'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.17.1_armv7l/c_ares-1.17.1-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.17.1_armv7l/c_ares-1.17.1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.17.1_i686/c_ares-1.17.1-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/c_ares/1.17.1_x86_64/c_ares-1.17.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7d3542bd270aa9ebf5f2b08273f547978290f5febc5142ff8f7fed363efc122e',
    armv7l: '7d3542bd270aa9ebf5f2b08273f547978290f5febc5142ff8f7fed363efc122e',
    i686: 'bb4a3bd9eaeff1e09b68f83514ca9a2a64414445bd040536cfe48c147a745641',
    x86_64: '2ab4479e0290444e44b842072c86c75e3a7a68c326d987be18f2cad01c19ea46'
  })

  def self.build
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
