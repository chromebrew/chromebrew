require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version '1.4.7'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{version}.tar.gz"
  source_sha256 'a4fb168def533f31ff2c07f7d9844bb3131e6799f094ebe77d0380adc987c20e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.7_armv7l/tdb-1.4.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.7_armv7l/tdb-1.4.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.7_i686/tdb-1.4.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.7_x86_64/tdb-1.4.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '27f08ebcd4a5a1e68afe3fc1db7af459720a8fd7fd9f893412d8d8e148021f41',
     armv7l: '27f08ebcd4a5a1e68afe3fc1db7af459720a8fd7fd9f893412d8d8e148021f41',
       i686: '2e07007ce032d5c36ba0817accfc8217cf106022663891e90ed60057cfa2104d',
     x86_64: '73c44eab45e9b417b60521602631c1c7e31f1ea2d3337abe8ad094146d5009b7'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'libbsd'
  depends_on 'libxslt' => :build

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
