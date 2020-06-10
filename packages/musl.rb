require 'package'

class Musl < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://www.musl-libc.org/'
  version '1.1.23'
  compatibility 'all'
  source_url 'https://www.musl-libc.org/releases/musl-1.1.23.tar.gz'
  source_sha256 '8a0feb41cef26c97dde382c014e68b9bb335c094bbc1356f6edaaf6b79bd14aa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/musl-1.1.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/musl-1.1.23-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/musl-1.1.23-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/musl-1.1.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd4fdc8b8d4bbe495283cfcaa0bf3574439d972dfbe4a1e1aa28927cc672f2089',
     armv7l: 'd4fdc8b8d4bbe495283cfcaa0bf3574439d972dfbe4a1e1aa28927cc672f2089',
       i686: 'cb4834f91df4afcbe7eccaf85abbbf4c80afa15d7e6ea9a220889c42e719ee8f',
     x86_64: '1d65413f0d246a3a350c354c03080e007a831552678d24ca4e125b515793bef8',
  })

  def self.build
    if ARCH == 'armv7l' or ARCH == 'aarch64'
      abi = 'eabihf'
      arch = 'armv7l'
    else
      abi = ''
      arch = ARCH
    end
    system 'env',
           'CC=cc',
           './configure',
           '--disable-debug',
           '--enable-warnings',
           "--bindir=#{CREW_PREFIX}/bin",
           "--host=#{arch}-cros-linux-musl#{abi}",
           "--syslibdir=#{CREW_PREFIX}/lib",
           "--prefix=#{CREW_PREFIX}/#{ARCH}-cros-linux-musl#{abi}"
    system "sed -i '/CROSS_COMPILE/d' config.mak"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts 'To use the Musl C library, use the `musl-gcc` compiler.'.lightblue
    puts '`musl-gcc` takes the same arguments as `cc`.'.lightblue
    puts
  end
end
