require 'package'

class Tar < Package
  description 'GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation.'
  homepage 'https://www.gnu.org/software/tar/'
  version '1.34'
  license 'BSD'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/tar/tar-1.34.tar.xz'
  source_sha256 '03d908cf5768cfe6b7ad588c921c6ed21acabfb2b79b788d1330453507647aed'

  

  def self.build
    system "./configure #{CREW_OPTIONS} --with-lzma=xz"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
