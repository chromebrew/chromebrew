require 'package'

class Cracklib < Package
  description 'The CrackLib package contains a library used to enforce strong passwords by comparing user selected passwords to words in chosen word lists.'
  homepage 'https://github.com/cracklib/cracklib'
  version '2.9.7'
  compatibility 'all'
  source_url 'https://github.com/cracklib/cracklib/archive/v2.9.7.tar.gz'
  source_sha256 'ff4e6c3f86494c93719f5e4186e2c3ea9e265f41972ec21f7b87852aced704e6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cracklib-2.9.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cracklib-2.9.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cracklib-2.9.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cracklib-2.9.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '53128dc07f528b00c3ebde2c90013ce35a66c61cf7128edacc9550902702c6f8',
     armv7l: '53128dc07f528b00c3ebde2c90013ce35a66c61cf7128edacc9550902702c6f8',
       i686: '9c0a651720f0bfc02fa666ff0cd6197e64dc484fc28e75eae0157696dd94e557',
     x86_64: 'dc987bfbb219cee1b5b09bf5fff728e312851a185635fd927455886cee8d0ec2',
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
