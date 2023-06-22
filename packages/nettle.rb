require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.7.2'
  license 'LGPL-3 or LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/nettle/nettle-#{version}.tar.gz"
  source_sha256 '8d2a604ef1cde4cd5fb77e422531ea25ad064679ff0adf956e78b3352e0ef162'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nettle/3.7.2_armv7l/nettle-3.7.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nettle/3.7.2_armv7l/nettle-3.7.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nettle/3.7.2_i686/nettle-3.7.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nettle/3.7.2_x86_64/nettle-3.7.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd8aa510c56d8e768789bfc85d7d48f4a82929fc09c63dc13164e56b5cd3944ff',
     armv7l: 'd8aa510c56d8e768789bfc85d7d48f4a82929fc09c63dc13164e56b5cd3944ff',
       i686: '0cf3d6e72bfb27525f21a8222361637f8899f3dd97abd2ba5eeb970c74835346',
     x86_64: '8f3f8f16263b2a1ccef1c078ee9443bcbe4f7a08fc9bb66ab1e5cf0715e7df0f'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'm4'
  depends_on 'openssl'

  def self.build
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
