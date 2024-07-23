require 'package'

class Shmux < Package
  description 'shell multiplexor'
  homepage 'https://github.com/shmux/shmux'
  version '1.0.2'
  license 'shmux'
  compatibility 'all'
  source_url 'https://github.com/shmux/shmux/archive/v1.0.2.tar.gz'
  source_sha256 '4b84dc3e0d72d054ed4730d130a509f43441fb61561c11a444d6ee65cbff9c04'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a8e89a4d6d087c646c5a0050fb09527a15b655838277fda2bcfd4ed37a1c10c5',
     armv7l: 'a8e89a4d6d087c646c5a0050fb09527a15b655838277fda2bcfd4ed37a1c10c5',
       i686: '9ae22a86f07497589e2414eee3a8bead32868bef93b4fdd619245c807e9baa82',
     x86_64: 'b29380a06c522510e36119614187713594a03c39d280b16015a42af336bc126a'
  })

  depends_on 'pcre'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
