require 'package'

class Musl < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://www.musl-libc.org/'
  version '1.1.21'
  source_url 'https://www.musl-libc.org/releases/musl-1.1.21.tar.gz'
  source_sha256 'c742b66f6f49c9e5f52f64d8b79fecb5a0f6e0203fca176c70ca20f6be285f44'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    if ARCH == 'armv7l'
      abi = 'eabihf'
    else
      abi = ''
    end
    system 'env',
           'CC=cc',
           './configure',
           '--disable-debug',
           '--enable-warnings',
           "--bindir=#{CREW_PREFIX}/bin",
           "--host=#{ARCH}-cros-linux-musl#{abi}",
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
