require 'package'

class Libmicrodns < Package
  description 'libmicrodns is a minimal cross-platform mDNS resolver and announcer.'
  homepage 'https://github.com/videolabs/libmicrodns/'
  version '0.2.0'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://github.com/videolabs/libmicrodns.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmicrodns/0.2.0_armv7l/libmicrodns-0.2.0-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmicrodns/0.2.0_armv7l/libmicrodns-0.2.0-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmicrodns/0.2.0_i686/libmicrodns-0.2.0-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmicrodns/0.2.0_x86_64/libmicrodns-0.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bae91599fad6ad6a9a1018b7d9e81482ead9513096b4606fb7913f9f7a25f007',
      armv7l: 'bae91599fad6ad6a9a1018b7d9e81482ead9513096b4606fb7913f9f7a25f007',
        i686: '301b452dee5090ddc78f129fdfde28fcf7a5c44d73509054543c04b5b67e4bc9',
      x86_64: '2648884537f4174ea224f3e0f5986cbe48b5e9a34358fb62b5d683c4eddbf656'
  })

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
              -Dtests=enabled builddir"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test'
  end
end
