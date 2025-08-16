require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version "1.4.14-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{version.split('-').first}.tar.gz"
  source_sha256 '6ce4b27498812d09237ece65a0d6dfac0941610e709848ecb822aa241084cd7a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53baf559d427ed3ce19345c80ba646bf06da804e6ddd44ad33f77f41135f4625',
     armv7l: '53baf559d427ed3ce19345c80ba646bf06da804e6ddd44ad33f77f41135f4625',
       i686: 'aa28173f9b0acd8793f9a8d67fc5ca963f1ab9cb320da9242327d2af1f2d2f02',
     x86_64: '88a0dfad31618513f4202465e0248455b27c948b161f8ed498863185d825abb4'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdb' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxslt' => :build
  depends_on 'python3' => :build

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS.sub(/--program-suffix.*/, '')}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
