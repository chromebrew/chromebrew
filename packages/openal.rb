require 'package'

class Openal < Package
  description 'OpenAL Soft is a software implementation of the cross-platform OpenAL 3D audio API appropriate for use with gaming applications and many other types of audio applications.'
  homepage 'https://openal-soft.org/'
  version '1.20.1'
  compatibility 'all'
  source_url 'https://github.com/kcat/openal-soft/archive/openal-soft-1.20.1.tar.gz'
  source_sha256 'c32d10473457a8b545aab50070fe84be2b5b041e1f2099012777ee6be0057c13'

  binary_url ({
    
  })
  binary_sha256 ({
   
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
