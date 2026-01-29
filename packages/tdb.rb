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
    aarch64: 'e84ef6595ae19a9e8cfe05011c61ad075920cdab39998f47554568e4f45cfe38',
     armv7l: 'e84ef6595ae19a9e8cfe05011c61ad075920cdab39998f47554568e4f45cfe38',
       i686: '4f3b8fe3cd0b25cfc96e74481268b8188d86e8a831363400b1ed15d91e49ee97',
     x86_64: 'e9315fad39ddb8bbc3d234380414ceda6346d0181323a51acfd426f62af72366'
  })

  depends_on 'docbook_xml' => :build
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
