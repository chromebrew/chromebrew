require 'package'

class Libbsd < Package
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki'
  version '0.8.6'
  source_url 'https://libbsd.freedesktop.org/releases/libbsd-0.8.6.tar.xz'
  source_sha256 '467fbf9df1f49af11f7f686691057c8c0a7613ae5a870577bef9155de39f9687'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
