require 'package'

class Libvisual_plugins < Package
  description 'Libvisual is a library that comes between applications and audio visualisation plugins.'
  homepage 'http://libvisual.org/'
  version '0.4.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Libvisual/libvisual/archive/libvisual-plugins-0.4.0.tar.gz'
  source_sha256 '862178e0f5c0c837f768b362c25eac613fc75ef91189cd929c635e23922b4c16'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'ef11ce122152c6492d7fa4754810ad49d0c866fb119600ea0496691c8fdd0ece',
     armv7l: 'ef11ce122152c6492d7fa4754810ad49d0c866fb119600ea0496691c8fdd0ece',
       i686: '6ba247e4d9a8fa78ea48a426b0f1e8393b1c6155884b99b93c8063ac7ac74f2b',
     x86_64: '15e813bd18834dc7b52c3878e0b05b785d585d9cf9145666ead898a7b92a28c5'
  })

  depends_on 'libvisual'

  def self.build
    Dir.chdir 'libvisual-plugins' do
      system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'libvisual-plugins' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
