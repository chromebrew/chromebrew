require 'package'

class Zile < Package
  description 'A small, fast, and powerful Emacs clone'
  homepage 'http://www.gnu.org/software/zile/'
  version '2.6.4'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/zile/zile-2.4.14.tar.gz'
  source_sha256 '7a78742795ca32480f2bab697fd5e328618d9997d6f417cf1b14e9da9af26b74'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84e007bac1bc55e332a27afbac816a02046f66c07e03d4c5b3481e0d96f7f7e2',
     armv7l: '84e007bac1bc55e332a27afbac816a02046f66c07e03d4c5b3481e0d96f7f7e2',
       i686: '04379e08cd765f182fcd3df2347bb92c156268a4b52799baeb4a6bd8815308e5',
     x86_64: '7e015099074a3376dbea22fa603fc394cafbb03f2116c1c8f523b09c9a25bb16'
  })

  depends_on 'acl' # R
  depends_on 'bdwgc'
  depends_on 'glibc' # R
  depends_on 'help2man' => :build
  depends_on 'ncurses' # R

  def self.build
    system './configure',
           "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses -I#{CREW_PREFIX}/include/ncursesw",
           "--prefix=#{CREW_PREFIX}",
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
