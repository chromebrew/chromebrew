require 'package'

class Jbigkit < Package
  description 'JBIG-KIT is a software implementation of the JBIG1 data compression standard'
  homepage 'https://www.cl.cam.ac.uk/~mgk25/jbigkit/'
  version '2.1-709282d'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/nu774/jbigkit.git'
  git_hashtag '709282d1ddcb35ab17134ea8cdda43ec2d647d2f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33d7651880ff70c07345d33a971dd5a6ecd3a630ab3dd7a35066bd0c4e1e8dcb',
     armv7l: '33d7651880ff70c07345d33a971dd5a6ecd3a630ab3dd7a35066bd0c4e1e8dcb',
       i686: 'd1a83c13c9e277c20f61a3ae708299e582efade2934cf58933600049f1080fdb',
     x86_64: '89ca5e27aa2ee40643ae9d0a4f26c44f74d2604dbdc4611102f257cd7e94bd62'
  })

  depends_on 'glibc' # R

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' pbmtools/jbgfuzz.pl"
  end

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    system 'make all'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
