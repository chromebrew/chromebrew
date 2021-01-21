require 'package'

class Tar < Package
  description 'GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation.'
  homepage 'https://www.gnu.org/software/tar/'
  version '1.33'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/tar/tar-1.33.tar.xz'
  source_sha256 '66a8344b1dc83a411d311bd1547e0176e56cc311f28ee94a30f84dafb3d9067e'

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
