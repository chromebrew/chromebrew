require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  version '1.4.12-py3.12'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{version.split('-').first}.tar.gz"
  source_sha256 '6ce4b27498812d09237ece65a0d6dfac0941610e709848ecb822aa241084cd7a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a05a203afe8fb38a7b37cdae1d2cc9efe8730ec5f609f815b65f748e4313d547',
     armv7l: 'a05a203afe8fb38a7b37cdae1d2cc9efe8730ec5f609f815b65f748e4313d547',
       i686: '81a0c31f9c45be79081f67f0b940049e63b4e17cf17da6c7645d2f9270063aeb',
     x86_64: '75e46c83dab2b9b741b5cc59e5a5135ab49cee6664ba3dd6998024762aeaaa29'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdb' => :build
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
