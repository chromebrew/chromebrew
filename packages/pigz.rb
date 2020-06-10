require 'package'

class Pigz < Package
  description 'A parallel implementation of gzip for modern multi-processor, multi-core machines'
  homepage 'https://zlib.net/pigz/'
  version '2.4'
  compatibility 'all'
  source_url 'https://zlib.net/pigz/pigz-2.4.tar.gz'
  source_sha256 'a4f816222a7b4269bd232680590b579ccc72591f1bb5adafcd7208ca77e14f73'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pigz-2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pigz-2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pigz-2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pigz-2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '10aa75b1ea4f2bd9acc84350fa30c0d152391e37517a2487febde4c6a82d329d',
     armv7l: '10aa75b1ea4f2bd9acc84350fa30c0d152391e37517a2487febde4c6a82d329d',
       i686: 'a9189537126b568f26aaeb6e8df2f8cb0a6519a47f277c796008be29db0dd87e',
     x86_64: '7254da818fd1658337f052cf2eaf4ecef66d1932eb3092703f335a847ccf7382',
  })

  def self.build
    system 'make'
    system 'gzip -9 pigz.1'
  end

  def self.install
    system "install -Dm755 pigz #{CREW_DEST_PREFIX}/bin/pigz"
    system "install -Dm755 unpigz #{CREW_DEST_PREFIX}/bin/unpigz"
    system "install -Dm644 pigz.1.gz #{CREW_DEST_PREFIX}/share/man/man1/pigz.1.gz"
  end
end
