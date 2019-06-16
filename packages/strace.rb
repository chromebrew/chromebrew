require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '5.1'
  source_url 'https://github.com/strace/strace/releases/download/v5.1/strace-5.1.tar.xz'
  source_sha256 'f5a341b97d7da88ee3760626872a4899bf23cf8dee56901f114be5b1837a9a8b'

  depends_on 'buildessential'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
