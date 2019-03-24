require 'package'

class Libatomic_ops < Package
  description 'Atomic memory update operations portable implementation'
  homepage 'https://github.com/ivmai/libatomic_ops'
  version '7.6.10'
  source_url 'https://github.com/ivmai/libatomic_ops/releases/download/v7.6.10/libatomic_ops-7.6.10.tar.gz'
  source_sha256 '587edf60817f56daf1e1ab38a4b3c729b8e846ff67b4f62a6157183708f099af'

  binary_url ({
  })
  binary_sha256 ({
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
