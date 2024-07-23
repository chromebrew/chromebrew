require 'package'

class Miniupnpc < Package
  description 'UPnP IGD client lightweight library'
  homepage 'http://miniupnp.free.fr/'
  version '2.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/miniupnp/miniupnp/archive/miniupnpc_2_1.tar.gz'
  source_sha256 '19c5b6cf8f3fc31d5e641c797b36ecca585909c7f3685a5c1a64325340537c94'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '312d76ffa9e5f86e7d1556b49a875387455cea3914f359aa2e9b9dee761a6adb',
     armv7l: '312d76ffa9e5f86e7d1556b49a875387455cea3914f359aa2e9b9dee761a6adb',
       i686: 'ec9f784b89804522b35d05c62c027ef359c03aa664b885619d942f72418474c5',
     x86_64: 'cc39583447b82b0599b6fd6807f6df3f728b35089d9d9a99d4c9064f58eb4fa0'
  })

  def self.patch
    # system "sed -i '139s,/usr,,' Makefile"
  end

  def self.build
    Dir.chdir 'miniupnpc' do
      if ARCH == 'x86_64'
        system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_SUFFIX=64"
      else
        system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
      end
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'miniupnpc' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
