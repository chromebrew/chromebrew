require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  @_ver = '1.4.8'
  version "#{@_ver}-py3.11"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{@_ver}.tar.gz"
  source_sha256 '8434c9c857d13ce3fa8466f75601f25c3693676b36919f159e0ad6121baf5ce8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.8-py3.11_armv7l/tdb-1.4.8-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.8-py3.11_armv7l/tdb-1.4.8-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.8-py3.11_i686/tdb-1.4.8-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tdb/1.4.8-py3.11_x86_64/tdb-1.4.8-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '446c1ee82faf153a38f0e2d04b1e187ba4111df6f97689a3491c9440e0d92b24',
     armv7l: '446c1ee82faf153a38f0e2d04b1e187ba4111df6f97689a3491c9440e0d92b24',
       i686: '15964b73b8dba92077bca5ed900d7be5a62bee9b26bc772ca04962afd12ad0be',
     x86_64: 'e041c23152bcdc8672f274baa1e4667db5505b6187e9541dabb0c50790229d96'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxslt' => :build
  depends_on 'python3' => :build

  def self.build
    system "./configure #{CREW_OPTIONS.sub(/--program-suffix.*/, '')}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
