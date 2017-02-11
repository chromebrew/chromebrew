require 'package'

class Flex < Package
  version '2.6.4'
  source_url 'https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz'
  source_sha1 'fafece095a0d9890ebd618adb1f242d8908076e1'

  depends_on 'm4'
  depends_on 'bison' => :build

  def self.build
    system "./configure", "--with-pic", "--disable-static", "--enable-shared"
    system "make"
    system "find . -name '*.so' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
