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
    aarch64: 'b4cd24e5d51084128d17934d22ae810214565de0b6b80bdcf5747b9f78448d2b',
     armv7l: 'b4cd24e5d51084128d17934d22ae810214565de0b6b80bdcf5747b9f78448d2b',
       i686: '43e70bf8a5679c9a05c83e9869a34e43c9b5f9dd7aa551d104e8af33ea5d724a',
     x86_64: '728249e946dc716f6d29a7dafb271d15d3674845a67cacd2c56d60981d149d45'
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
    Dir.chdir(CREW_DEST_LIB_PREFIX) do
      %w[
        libjbig.so.2
        libjbig.so.2.0.0
        libjbig85.so
        libjbig85.so.2
        libjbig85.so.2.0.0
      ].each do |lib|
        FileUtils.ln_sf 'libjbig.so.0', lib
      end
    end
  end
end
