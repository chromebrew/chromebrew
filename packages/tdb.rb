require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version '1.4.5'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{version}.tar.gz"
  source_sha256 'bcfced884f7031080998b5c4b1c5dce57567055f79417f86dba40dcde99a0e41'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.5_armv7l/tdb-1.4.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.5_armv7l/tdb-1.4.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.5_i686/tdb-1.4.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.5_x86_64/tdb-1.4.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bba3ef3c4c68dc1933a1a33d1500752d745663742f96483998f043291c778450',
     armv7l: 'bba3ef3c4c68dc1933a1a33d1500752d745663742f96483998f043291c778450',
       i686: '17d6f6be8c555a20dc95f04d254477593373d5b37404b8ef714ddb03a685d2b2',
     x86_64: 'f47f3199372d31c5abb9cf4c38e39d25bc229f20e85c71bb695e7c1db2d5fd82'
  })

  depends_on 'docbook_xsl'
  depends_on 'libbsd'
  depends_on 'libxslt'

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
