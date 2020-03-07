require 'package'

class Ecasound < Package
  description 'Ecasound is a software package designed for multitrack audio processing.'
  homepage 'https://ecasound.seul.org/ecasound/'
  version '1.0.21'
  source_url 'https://nosignal.fi/download/ecasound-2.9.3.tar.gz'
  source_sha256 '468bec44566571043c655c808ddeb49ae4f660e49ab0072970589fd5a493f6d4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ecasound-1.0.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ecasound-1.0.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ecasound-1.0.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ecasound-1.0.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8bbf7d4b25da6f034a519a8bbb213acd9e4d328c8be0ffcb1ef7973faf1932ea',
     armv7l: '8bbf7d4b25da6f034a519a8bbb213acd9e4d328c8be0ffcb1ef7973faf1932ea',
       i686: '1cce14a38401659698c2500e9d09aaf732c46343438601745d46cbf162fcd5cf',
     x86_64: 'f8242a29cdc5a9a3abcabb1455a457c39ed08d195b7aa17df859f0ad845ca6d4',
  })

  depends_on 'libaudiofile'
  depends_on 'libsndfile'
  depends_on 'python27'

  def self.patch
    # Fix ./configure: line 8777: /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/readline ./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
