require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '4.16'
  source_url 'https://downloads.sourceforge.net/project/strace/strace/4.16/strace-4.16.tar.xz'
  source_sha256 '98487cb5178ec1259986cc9f6e2a844f50e5d1208c112cc22431a1e4d9adf0ef'

  depends_on 'buildessential'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
