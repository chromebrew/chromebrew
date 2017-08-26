require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.2.0'
  source_url 'https://github.com/neovim/neovim/archive/v0.2.0.tar.gz'
  source_sha256 '72e263f9d23fe60403d53a52d4c95026b0be428c1b9c02b80ab55166ea3f62b5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3dc12d8a905444dff6a70790d8b0ae27899bbb4b310f44c1d1d30e3ef9f15bcf',
     armv7l: '3dc12d8a905444dff6a70790d8b0ae27899bbb4b310f44c1d1d30e3ef9f15bcf',
       i686: '0ae138abca8d035eb11658d8ca8446f5c7b6c6a43c8554cdbc99c8813698223d',
     x86_64: '16f6dfd198931f3162e1cf6054224c1e4e8059403597d621ab54b4a421fe89ed',
  })

  depends_on 'libtool'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'cmake'
  depends_on 'gcc'
  depends_on 'pkgconfig'
  depends_on 'unzip'

  def self.build
    system "make", "CMAKE_BUILD_TYPE=RelWithDebInfo"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
