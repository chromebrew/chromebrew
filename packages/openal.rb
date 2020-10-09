require 'package'

class Openal < Package
  description 'OpenAL Soft is a software implementation of the cross-platform OpenAL 3D audio API appropriate for use with gaming applications and many other types of audio applications.'
  homepage 'https://openal-soft.org/'
  version '1.20.1'
  compatibility 'all'
  source_url 'https://github.com/kcat/openal-soft/archive/openal-soft-1.20.1.tar.gz'
  source_sha256 'c32d10473457a8b545aab50070fe84be2b5b041e1f2099012777ee6be0057c13'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openal-1.20.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openal-1.20.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openal-1.20.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openal-1.20.1-chromeos-x86_64.tar.xz',
    
  })
  binary_sha256 ({
    aarch64: 'f4fad76fa80a35e5ed2b551623610a764942c599caa606474bb9585da30dd648',
     armv7l: 'f4fad76fa80a35e5ed2b551623610a764942c599caa606474bb9585da30dd648',
       i686: '34754828e5fdf5632b1a72f5632568fd3484b1edca17d14692f7bfa5578a0752',
     x86_64: 'ad3c151c3cd255fac16bd21bf207ebcc14928d740691fc74ee5d5537627bb2d7',
   
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
