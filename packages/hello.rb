require 'package'

class Hello < Package
  description 'GNU Hello is another implementation of the classic program that prints “Hello, world!”'
  homepage 'https://www.gnu.org/software/hello/'
  version '2.10'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/hello/hello-2.10.tar.gz'
  source_sha256 '31e066137a962676e89f69d1b65382de95a7ef7d914b8cb956f41ea72e0f516b'

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
