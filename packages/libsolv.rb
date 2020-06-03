require 'package'

class Libsolv < Package
  description 'Library for solving packages and reading repositories'
  homepage 'https://en.opensuse.org/openSUSE:Libzypp_satsolver'
  version '0.7.14'
  #compatibility 'all'
  source_url 'https://github.com/openSUSE/libsolv/archive/0.7.14.tar.gz'
  source_sha256 '34a67c23cedd38a949607d8cdbd867aa4b07556f18a57e17162ac962bbdbbf54'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsolv-0.7.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsolv-0.7.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsolv-0.7.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsolv-0.7.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4a559dd64cbc0a45f291bb3b7b500bcb04119559987830df0066176fc48867a9',
     armv7l: '4a559dd64cbc0a45f291bb3b7b500bcb04119559987830df0066176fc48867a9',
       i686: '35f045613c622b24224117ef8e203fe37c6bdf36dff4b701ca8263214e1a4122',
     x86_64: '1c9062a1b1cc87345941eedb01d7aacd9f942c7924d81db8c52d77cde19a32ed',
  })

  depends_on 'lzma'
  depends_on 'swig'
  depends_on 'zstd'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DENABLE_BZIP2_COMPRESSION=ON',
             '-DENABLE_LZMA_COMPRESSION=ON',
             '-DENABLE_ZSTD_COMPRESSION=ON',
             '-DENABLE_PYTHON=ON',
             '-DENABLE_RUBY=ON',
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
