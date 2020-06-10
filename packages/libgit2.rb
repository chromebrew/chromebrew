require 'package'

class Libgit2 < Package
  description 'A portable, pure C implementation of the Git core methods'
  homepage 'https://libgit2.org/'
  version '0.28.2'
  compatibility 'all'
  source_url 'https://github.com/libgit2/libgit2/archive/v0.28.2.tar.gz'
  source_sha256 '42b5f1e9b9159d66d86fff0394215c5733b6ef8f9b9d054cdd8c73ad47177fc3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgit2-0.28.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgit2-0.28.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgit2-0.28.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgit2-0.28.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ea0358650faf4cf70c1daeb6faaddf456fee8a2230b7854ca1a57f81abcca2e9',
     armv7l: 'ea0358650faf4cf70c1daeb6faaddf456fee8a2230b7854ca1a57f81abcca2e9',
       i686: '18d4c0cb5fbaffcbd720c33879c3ddad327d3b926181911aa94636cb77679f36',
     x86_64: 'fe5e80b43e166d1dd28a4f8543c509c84ed1e8f32193b5012cc6a0e354bd5990',
  })

  depends_on 'python3'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DLIB_INSTALL_DIR=#{CREW_LIB_PREFIX}",
             '..'
      system 'cmake --build .'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
