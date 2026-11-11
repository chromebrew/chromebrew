require 'package'

class Jbigkit < Package
  description 'JBIG-KIT is a software implementation of the JBIG1 data compression standard'
  homepage 'https://www.cl.cam.ac.uk/~mgk25/jbigkit/'
  version '2.2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.cl.cam.ac.uk/~mgk25/jbigkit/download/jbigkit-#{version}.tar.gz"
  source_sha256 '3302109c93b7befbffa3cfe8bceb4355f19dea0ee7dcb5f33710b1648bf6645c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39b54682e962a5b141bd9179079001f428899cc1de27c97115054263483d8796',
     armv7l: '39b54682e962a5b141bd9179079001f428899cc1de27c97115054263483d8796',
       i686: '8da0794e3f7090d174e6f01fbbae5eadf0847e2fd6eb8937df951638f5f52a32',
     x86_64: '75ff730d0b7aaabfb10a07d1a67aaf2c25b076fca944a5506bf49aa73e30ea8a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.patch
    patch = [
      [
        # Shared library patch.
        'https://gitlab.archlinux.org/archlinux/packaging/packages/jbigkit/-/raw/main/jbigkit-2.2-shared_lib.patch',
        '58d80618c27dd089a2f3db87d91bf37fa443d1ef8418f3d2958aabb850120b2a'
      ]
    ]
    ConvenienceFunctions.patch(patch) if version.eql?('2.2')
  end

  def self.build
    system 'make all'
  end

  def self.check
    Dir.chdir 'libjbig' do
      system 'make test'
    end
  end

  def self.install
    Dir.chdir 'libjbig' do
      %w[jbig.h jbig_ar.h jbig85.h].each do |hdr|
        FileUtils.install hdr, "#{CREW_DEST_PREFIX}/include/#{hdr}", mode: 0o644
      end
      %w[libjbig85.so.2.2 libjbig85.so libjbig.so.2.2 libjbig.so].each do |lib|
        FileUtils.install lib, "#{CREW_DEST_LIB_PREFIX}/#{lib}", mode: 0o644
      end
    end
    Dir.chdir 'pbmtools' do
      %w[jbgtopbm jbgtopbm85 pbmtojbg pbmtojbg85].each do |bin|
        FileUtils.install bin, "#{CREW_DEST_PREFIX}/bin/#{bin}", mode: 0o755
      end
      %w[jbgtopbm.1 pbmtojbg.1].each do |man|
        FileUtils.install man, "#{CREW_DEST_MAN_PREFIX}/man1/#{man}", mode: 0o644
      end
    end
  end
end
