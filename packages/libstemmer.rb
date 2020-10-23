require 'package'

class Libstemmer < Package
  description 'Snowball Stemming Algorithms'
  homepage 'https://snowballstem.org/'
  version '78c149'
  compatibility 'all'
  source_url 'https://github.com/zvelo/libstemmer/archive/78c149a3a6f262a35c7f7351d3f77b725fc646cf.tar.gz'
  source_sha256 '9bbd1bd2b7829f6bdafba97667fc795b3a80785c2285a5b73c3006b0bf3db688'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libstemmer-78c149-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libstemmer-78c149-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libstemmer-78c149-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libstemmer-78c149-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '854bc6cb2855c76b052d49fc8ac0c2dbc3766fede27ba6eac71846eef85f9351',
     armv7l: '854bc6cb2855c76b052d49fc8ac0c2dbc3766fede27ba6eac71846eef85f9351',
       i686: 'aa04ec939e77fcce2cbbad9498f6d13c4ccd351bfef9540fa9ef9c13c467ba94',
     x86_64: '687765fc1f522249eef1d40b85f5a5cab1483be44710af5ba37ae9f324d16c0a',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DBUILD_SHARED_LIBS=ON',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    Dir.chdir CREW_DEST_PREFIX do
      FileUtils.mv 'lib', 'lib64' if ARCH == 'x86_64'
    end
  end
end
