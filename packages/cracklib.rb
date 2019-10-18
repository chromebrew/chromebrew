require 'package'

class Cracklib < Package
  description 'The CrackLib package contains a library used to enforce strong passwords by comparing user selected passwords to words in chosen word lists.'
  homepage 'https://github.com/cracklib/cracklib'
  version '2.9.7'
  source_url 'https://github.com/cracklib/cracklib/archive/v2.9.7.tar.gz'
  source_sha256 'ff4e6c3f86494c93719f5e4186e2c3ea9e265f41972ec21f7b87852aced704e6'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    Dir.chdir 'src' do
      system './autogen.sh'
      system "./configure \
              --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              --disable-static"
    end
  end

  def self.install
    Dir.chdir 'src' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
    
  def self.test
    Dir.chdir 'src' do
      system 'make test'
    end
  end
end
