require 'package'

class Diy < Package
  description 'data-parallel out-of-core library'
  homepage 'https://github.com/diatomic/diy'
  version '3.5.0'
  compatibility 'all'
  source_url 'https://github.com/diatomic/diy/archive/3.5.0.tar.gz'
  source_sha256 'b3b5490441d521b6e9b33471c782948194bf95c7c3df3eb97bc5cf4530b91576'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/diy-3.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/diy-3.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/diy-3.5.0-chromeos-i686.tar.xz',
    x86_64: 'file:///home/chronos/user/chromebrew/release/x86_64/diy-3.5.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256 ({
    aarch64: '1f7e1d0b9c3f4c3675a243ad85082057be425544a1e2a84eb7bd0a1c1f5f059d',
     armv7l: '1f7e1d0b9c3f4c3675a243ad85082057be425544a1e2a84eb7bd0a1c1f5f059d',
       i686: 'dbfcfab6e452536ccedb176f659e031fdc4e08f5fa8bc6e57d19247bffcd7dca',
     x86_64: '154c20b27c6bccbd7cc1dfb392e9946f09648888847a10141a3374df08ad29bb',
  })

  depends_on 'openmpi'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
