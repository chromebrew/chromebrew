require 'package'

class Gccmakedep < Package
  description 'A utility to list the resource database of an X application.'
  homepage 'https://x.org'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/gccmakedep-1.0.3.tar.gz'
  source_sha256 'f9e2e7a590e27f84b6708ab7a81e546399b949bf652fb9b95193e0e543e6a548'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gccmakedep-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gccmakedep-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gccmakedep-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gccmakedep-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '768024cf21b9a07a48bf15edd114b1c6e0f3a741c72e2a71cb262c1115d2e43e',
     armv7l: '768024cf21b9a07a48bf15edd114b1c6e0f3a741c72e2a71cb262c1115d2e43e',
       i686: '70429af7d9233dc37fadfde9eae739dd55fb497f6315c54ec3430c3b1060ed87',
     x86_64: 'c90cb0f4a6dc67e2f2da5d39a3038e8db28ed1f0949373b56aac6c2f5b302b96',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
