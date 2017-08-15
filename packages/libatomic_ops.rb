require 'package'

class Libatomic_ops < Package
  description 'Atomic memory update operations portable implementation'
  homepage 'https://github.com/ivmai/libatomic_ops'
  version '7.6.0'
  source_url 'https://github.com/ivmai/libatomic_ops/releases/download/v7.6.0/libatomic_ops-7.6.0.tar.gz'
  source_sha256 '8e2c06d1d7a05339aae2ddceff7ac54552854c1cbf2bb34c06eca7974476d40f'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libatomic_ops-7.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libatomic_ops-7.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libatomic_ops-7.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libatomic_ops-7.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ccbc4989f3ac6368de4f7c50dc419ec91c00cdcd3038fd42aa7bc05d93f666af',
     armv7l: 'ccbc4989f3ac6368de4f7c50dc419ec91c00cdcd3038fd42aa7bc05d93f666af',
       i686: '975680fbbd2aa398ee2cfeada7251e22c80595f8cf4a19b3b0fc9c43bcc07bd0',
     x86_64: 'ec3cc2c64f4a730b931ca414a4d66f0789ff951c4d6f7e4bc549f0ca6ac72688',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
