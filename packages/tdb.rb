require 'buildsystems/autotools'

class Tdb < Autotools
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version "1.4.15-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{version.split('-').first}.tar.gz"
  source_sha256 'fba09d8df1f1b9072aeae8e78b2bd43c5afef20b2f6deefa633aa14a377a8dd2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3698cc5856db7656f2094ec30e35dec63a25155b47b120799386bfab2c73f95d',
     armv7l: '3698cc5856db7656f2094ec30e35dec63a25155b47b120799386bfab2c73f95d',
       i686: 'fda29498309b065e20d7506c221a6f7778aa1ffc4ab01d59d1372b1dbf698c08',
     x86_64: 'f9eefb6e611a40cdc6c00040a07304486a0ccbbe872b2f05e471cf6aeaa94cb4'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'gdb' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libxslt' => :build
  depends_on 'python3' => :build

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS.sub(/--program-suffix.*/, '')}"
    system 'make'
  end
end
