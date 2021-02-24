require 'package'

class Libgdiplus < Package
  description 'The mono library that provides a GDI+-compatible API on non-windows operating systems.'
  homepage 'https://www.mono-project.com/docs/gui/libgdiplus/'
  version '6.0.5-2'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/libgdiplus/libgdiplus-6.0.5.tar.gz'
  source_sha256 'b81e4e5cc3e4831b2945de08bef26eb1bdcd795aeaf8f971b221c51213a025ef'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgdiplus-6.0.5-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgdiplus-6.0.5-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgdiplus-6.0.5-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgdiplus-6.0.5-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1f6af1a888b6892619e1e75d4d81626e44e683e4bc416cbc2ecf67fd56395bb9',
     armv7l: '1f6af1a888b6892619e1e75d4d81626e44e683e4bc416cbc2ecf67fd56395bb9',
       i686: 'f82da1a7932e0f10234c60662f9f1cbbd6d47d35015bdd32c1394f782faa59cf',
     x86_64: 'f36f2f2729d1184131c855de987d432fed17a8c848f044768c4b20a9fb35267e'
  })

  depends_on 'glib'
  depends_on 'cairo'
  depends_on 'graphite'
  depends_on 'libexif'
  depends_on 'libtiff'
  depends_on 'libpng'
  depends_on 'libwebp'
  depends_on 'giflib'
  depends_on 'imake' => :build

  def self.build
    system "CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-libexif \
      --with-libtiff \
      --with-jpeg \
      --with-libgif \
      --with-x11"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
