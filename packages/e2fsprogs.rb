require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'http://e2fsprogs.sourceforge.net/'
  version '1.45.6'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.45.6/e2fsprogs-1.45.6.tar.xz'
  source_sha256 'ffa7ae6954395abdc50d0f8605d8be84736465afc53b8938ef473fcf7ff44256'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
