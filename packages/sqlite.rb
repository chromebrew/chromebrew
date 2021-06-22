require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.36.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://sqlite.org/2021/sqlite-autoconf-3360000.tar.gz'
  source_sha256 'bd90c3eb96bee996206b83be7065c9ce19aef38c3f4fb53073ada0d0b69bbce3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.36.0_armv7l/sqlite-3.36.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.36.0_armv7l/sqlite-3.36.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.36.0_i686/sqlite-3.36.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.36.0_x86_64/sqlite-3.36.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '57ba561acfc24bc8a9eed5f0ef8d32726fd9c2970fe0d1e17b1764df6f3bfade',
     armv7l: '57ba561acfc24bc8a9eed5f0ef8d32726fd9c2970fe0d1e17b1764df6f3bfade',
       i686: '2f54951a8d62f28262771b12ec0c04ecd9162bedad060d2c630e45a074c0a0a1',
     x86_64: '7ea92b093047843e47d9a383ecb05831774824913b562c245c9460875773cdb3'
  })

  depends_on 'libedit'
  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
      --enable-shared \
      --enable-editline \
      --enable-readline \
      --enable-fts5 \
      --enable-json1 \
      --enable-session \
      --with-pic"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
