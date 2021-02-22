require 'package'

class Hello < Package
  description 'GNU Hello is another implementation of the classic program that prints “Hello, world!”'
  homepage 'https://www.gnu.org/software/hello/'
  version '2.10'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/hello/hello-2.10.tar.gz'
  source_sha256 '31e066137a962676e89f69d1b65382de95a7ef7d914b8cb956f41ea72e0f516b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hello-2.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hello-2.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hello-2.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hello-2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5dc4429669eb28c742dfea306e988b168f4fd871bfca7aa29d69c6594a24a7f6',
     armv7l: '5dc4429669eb28c742dfea306e988b168f4fd871bfca7aa29d69c6594a24a7f6',
       i686: '5cd41999885734e0e380fb90c1f51da9a5280ff95d44fa1cc495d007158ebf81',
     x86_64: 'af1e0ecfc8043022dc39fb531602abd619153f7e4522c27b393e154c16c1f13d',
  })

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
