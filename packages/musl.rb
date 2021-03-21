require 'package'

class Musl < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://www.musl.libc.org/'
  version '1.2.2'
  compatibility 'all'
  source_url 'https://musl.libc.org/releases/musl-1.2.2.tar.gz'
  source_sha256 '9b969322012d796dc23dda27a35866034fa67d8fb67e0e2c45c913c3d43219dd'

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
