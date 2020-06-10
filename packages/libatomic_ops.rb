require 'package'

class Libatomic_ops < Package
  description 'Atomic memory update operations portable implementation'
  homepage 'https://github.com/ivmai/libatomic_ops'
  version '7.6.10'
  compatibility 'all'
  source_url 'https://github.com/ivmai/libatomic_ops/releases/download/v7.6.10/libatomic_ops-7.6.10.tar.gz'
  source_sha256 '587edf60817f56daf1e1ab38a4b3c729b8e846ff67b4f62a6157183708f099af'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libatomic_ops-7.6.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libatomic_ops-7.6.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libatomic_ops-7.6.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libatomic_ops-7.6.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0844abb0df05ad6c0f9b72b0cbb5e20bb51e4d8c8e9889e44a146aa38693d3ff',
     armv7l: '0844abb0df05ad6c0f9b72b0cbb5e20bb51e4d8c8e9889e44a146aa38693d3ff',
       i686: 'bf9998a0696908b73023aec0c8cfa08f25d083184355958d96b3f8655f510293',
     x86_64: 'f5a1470043d79aca3925da878ff395d3bdcad179d3ed308f4aea4e0f55cf348c',
  })

  def self.build
    system './configure',
	   '--enable-shared',
	   '--disable-static',
	   "--prefix=#{CREW_PREFIX}",
	   "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
