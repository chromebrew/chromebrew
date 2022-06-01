require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version '1.4.6'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{version}.tar.gz"
  source_sha256 'd6892bd8befe04a77642a1dd56e4a879349bf1cf5b2c0bf5fb841061938def0b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.6_armv7l/tdb-1.4.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.6_armv7l/tdb-1.4.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.6_i686/tdb-1.4.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.6_x86_64/tdb-1.4.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8396dd401979dd2865079e3b4b14b36026f1b9d74f0a555fa382355f9eca3dc6',
     armv7l: '8396dd401979dd2865079e3b4b14b36026f1b9d74f0a555fa382355f9eca3dc6',
       i686: '37f60900b780ddeda64dd2dd0d9739266a0f27ef6ebbb9b6079dd1dccc3099df',
     x86_64: 'd3e0bf820e71c2a0c6a8630eb215b41049a6595619b0bcc679e615581d6d9904'
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
