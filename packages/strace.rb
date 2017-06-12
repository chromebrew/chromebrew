require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '4.16'
  source_url 'https://downloads.sourceforge.net/project/strace/strace/4.16/strace-4.16.tar.xz'
  source_sha1 'b780a8cd2e60ea836cfd3468e0f81623a346d180'

  depends_on 'buildessential'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
