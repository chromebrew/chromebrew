require 'package'

class Libvncserver < Package
  description 'LibVNCServer/LibVNCClient are cross-platform C libraries that allow you to easily implement VNC server or client functionality in your program.'
  homepage 'https://github.com/LibVNC/libvncserver'
  version '0.9.13'
  license 'GPL-2, GPL-2+, LGPL-2.1+, BSD and MIT'
  compatibility 'all'
  source_url "https://github.com/LibVNC/libvncserver/archive/LibVNCServer-#{version}.tar.gz"
  source_sha256 '0ae5bb9175dc0a602fe85c1cf591ac47ee5247b87f2bf164c16b05f87cbfa81a'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libvncserver-0.9.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libvncserver-0.9.13-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/libvncserver-0.9.13-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/libvncserver-0.9.13-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c84b627885cfc0bbfcbf03741b8c6ec4fdd6d5340bb1079833715c03737e4fc3',
     armv7l: 'c84b627885cfc0bbfcbf03741b8c6ec4fdd6d5340bb1079833715c03737e4fc3',
       i686: '3e6c5710b2167ebf5ed3eeff7eb1e17cf9ca7f4780ab11430f592325cd4bed6f',
     x86_64: '2fbd014d5e4a7da80fd56a101c490a7d7cc417f8569832cfbee09613f1b28ba5'
  })

  depends_on 'ffmpeg'
  depends_on 'gtk2'
  depends_on 'libjpeg'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DWITH_SYSTEMD=OFF \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
