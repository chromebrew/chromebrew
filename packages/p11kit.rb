require 'package'
  
class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.23.22'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit/archive/0.23.22.tar.gz'
  source_sha256 'e4bf1e374b3c0950a724cf367bd52201519f4b7025c8e9902a274123cc232560'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.22-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.22-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.22-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/p11kit-0.23.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'd62b5c7216b9b271584147ec0b5c432ef1f993c0985be2c77ec7b681981eb2a8',
      armv7l: 'd62b5c7216b9b271584147ec0b5c432ef1f993c0985be2c77ec7b681981eb2a8',
        i686: 'e7a2a1566f4219929789357682f26a6a3f2582f030d1a29fa75bfe53d1010472',
      x86_64: 'fbbf0478445e54d17f6db35d79ae9c5b7fdf5fcfe88e2fb429eb7e5c1c933035',
  })

  depends_on 'libffi'
  depends_on 'libtasn1'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      build"
    system "meson configure build"
    system "ninja -C build"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

end
