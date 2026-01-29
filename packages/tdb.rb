require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version "1.4.15-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{version.split('-').first}.tar.gz"
  source_sha256 'fba09d8df1f1b9072aeae8e78b2bd43c5afef20b2f6deefa633aa14a377a8dd2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb421fffe1ad6455ef117cfdec23eba6b4f6726c942f6f8580b029ba3f12286d',
     armv7l: 'fb421fffe1ad6455ef117cfdec23eba6b4f6726c942f6f8580b029ba3f12286d',
       i686: 'f52321235c9ea865a35548230756540ba8f508efbf80a0525a880f4389b3bd16',
     x86_64: 'f1b7e973def25de7d991adea278c12a3bcc8c89b7efaa3859bc7fdc1b1ec0958'
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
