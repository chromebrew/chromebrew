require 'package'

class Musl < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.libc.org/'
  version '1.2.2'
  license 'MIT, LGPL-2 and GPL-2'
  compatibility 'all'
  source_url "https://musl.libc.org/releases/musl-#{version}.tar.gz"
  source_sha256 '9b969322012d796dc23dda27a35866034fa67d8fb67e0e2c45c913c3d43219dd'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '3ed631095e644fc8477a73c26b29970af21fea79ee65380ede17bb1d9b8116d3',
     armv7l: '3ed631095e644fc8477a73c26b29970af21fea79ee65380ede17bb1d9b8116d3',
       i686: 'eaff89a590abbcf849bc427a9629f389fee5d3ece2173272c2e4d1e858ec2008',
     x86_64: 'aad8afc109cc3946c1d9b0bd079fe1973f8b28decc79f19b10dc7acc9a44f797'
  })

  def self.build
    if (ARCH == 'armv7l') || (ARCH == 'aarch64')
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
