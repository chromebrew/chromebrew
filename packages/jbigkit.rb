require 'package'

class Jbigkit < Package
  description 'JBIG-KIT is a software implementation of the JBIG1 data compression standard'
  homepage 'https://www.cl.cam.ac.uk/~mgk25/jbigkit/'
  version '2.1-6.1ubuntu2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/jbigkit/2.1-6.1ubuntu2/jbigkit_2.1.orig.tar.gz'
  source_sha256 'de7106b6bfaf495d6865c7dd7ac6ca1381bd12e0d81405ea81e7f2167263d932'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33d7651880ff70c07345d33a971dd5a6ecd3a630ab3dd7a35066bd0c4e1e8dcb',
     armv7l: '33d7651880ff70c07345d33a971dd5a6ecd3a630ab3dd7a35066bd0c4e1e8dcb',
       i686: 'd1a83c13c9e277c20f61a3ae708299e582efade2934cf58933600049f1080fdb',
     x86_64: 'ddbc74c69e240fd2b6d25e476b0746cca3adcad4e2a94fc662ef91d204785037'
  })

  depends_on 'glibc' # R

  def self.patch
    downloader "https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/jbigkit/#{version}/jbigkit_#{version}.debian.tar.xz", '6e487c3eb8e6ac36db05678628b9ef889887551af053c0858e383e45b85eef19'
    system "tar xf jbigkit_#{version}.debian.tar.xz"
    File.foreach 'debian/patches/series' do |patch|
      system "patch -Np1 -i debian/patches/#{patch}"
    end
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' pbmtools/jbgfuzz.pl"
    system "sed -i 's,lib/\\$(DEB_HOST_MULTIARCH),#{ARCH_LIB},g' Makefile"
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make all'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
