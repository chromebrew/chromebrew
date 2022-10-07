require 'package'

class Libgdiplus < Package
  description 'The mono library that provides a GDI+-compatible API on non-windows operating systems.'
  homepage 'https://www.mono-project.com/docs/gui/libgdiplus/'
  version '6.0.5-4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/libgdiplus/libgdiplus-6.0.5.tar.gz'
  source_sha256 'b81e4e5cc3e4831b2945de08bef26eb1bdcd795aeaf8f971b221c51213a025ef'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgdiplus/6.0.5-4_armv7l/libgdiplus-6.0.5-4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgdiplus/6.0.5-4_armv7l/libgdiplus-6.0.5-4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgdiplus/6.0.5-4_i686/libgdiplus-6.0.5-4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgdiplus/6.0.5-4_x86_64/libgdiplus-6.0.5-4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '52ec24e838ea7137710feb6b4c19c52fbd3780d7e1bfb64fe21586166673acab',
     armv7l: '52ec24e838ea7137710feb6b4c19c52fbd3780d7e1bfb64fe21586166673acab',
       i686: '5813d86e616f4ffc74be033c0c470013d335f63aef599f9cb5dd26d36eb99b02',
     x86_64: 'db34904552014d5c0bf6d0fbef79cc253934d4bc5044b85fa780ead0ead7e61d'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'graphite'
  depends_on 'imake' => :build
  depends_on 'libexif'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
