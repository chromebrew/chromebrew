require 'package'

class Tdb < Package
  description 'tdb is a simple database API for sharing structures between parts of Samba'
  homepage 'https://tdb.samba.org/'
  @_ver = '1.4.10'
  version "#{@_ver}-py3.12"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/tdb/tdb-#{@_ver}.tar.gz"
  source_sha256 '02338e33c16c21c9e29571cef523e76b2b708636254f6f30c6cf195d48c62daf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdbc6b59396b9e63c9613277aa69f2234ac2f33efc02e61676b557de276ca280',
     armv7l: 'cdbc6b59396b9e63c9613277aa69f2234ac2f33efc02e61676b557de276ca280',
       i686: 'c211290c6eaccca7c95f64eca16bb4992454ae2a069bcf67e4222dabaabc1131',
     x86_64: 'd1e13d3f5c4201db4b748c567ae48a1e88e40a68983199fa07cbe968822d0d49'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'gcc_lib' # R
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
