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
    aarch64: '869c46af87e6828afb3343c472d6f44e93f9cbca3c8ddfca9674cc997b963339',
     armv7l: '869c46af87e6828afb3343c472d6f44e93f9cbca3c8ddfca9674cc997b963339',
       i686: 'c073e3b4552e61a1601c5038133e3c36c2c56cc740f3650ffbf1f176ab2e22c3',
     x86_64: '19f09414803c8dac3596267d55de2324ca9c564379bb336f82ff853f53b11f4e'
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
