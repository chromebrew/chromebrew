require 'package'

class Openal < Package
  description 'OpenAL Soft is a software implementation of the cross-platform OpenAL 3D audio API appropriate for use with gaming applications and many other types of audio applications.'
  homepage 'https://openal-soft.org/'
  version '1.20.0'
  compatibility 'all'
  source_url 'https://github.com/kcat/openal-soft/archive/openal-soft-1.20.0.tar.gz'
  source_sha256 'ea1582337ce0344754cc6742b9a5da248fb971fb6fbcc592f843f765423d9265'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openal-1.20.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openal-1.20.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openal-1.20.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openal-1.20.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eb94add03a88623b6915da3b531fea73b947c4caf49d89582a90737c6282ea53',
     armv7l: 'eb94add03a88623b6915da3b531fea73b947c4caf49d89582a90737c6282ea53',
       i686: 'e75fb5996dedacf7125def831f5ba8483de171d0b7061993acb6032508de94a1',
     x86_64: '2bd3bff607f873b741093e459e80f0fe83a039fbcfbe4f45f7fd16891a46e571',
  })

  def self.build
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DALSOFT_EXAMPLES=OFF',
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
