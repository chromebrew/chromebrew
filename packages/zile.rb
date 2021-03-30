require 'package'

class Zile < Package
  description 'A small, fast, and powerful Emacs clone'
  homepage 'http://www.gnu.org/software/zile/'
  version '2.4.14-1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/zile/zile-2.4.14.tar.gz'
  source_sha256 '7a78742795ca32480f2bab697fd5e328618d9997d6f417cf1b14e9da9af26b74'

  depends_on 'bdwgc'
  depends_on 'help2man' => :build

  def self.build
    system "env CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw
          ./configure #{CREW_OPTIONS} \
	           --disable-dependency-tracking"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
