require 'package'

class Libvncserver < Package
  description 'LibVNCServer/LibVNCClient are cross-platform C libraries that allow you to easily implement VNC server or client functionality in your program.'
  homepage 'https://github.com/LibVNC/libvncserver'
  @_ver = '0.9.13'
  version "#{@_ver}-1"
  license 'GPL-2, GPL-2+, LGPL-2.1+, BSD and MIT'
  compatibility 'all'
  source_url "https://github.com/LibVNC/libvncserver/archive/LibVNCServer-#{@_ver}.tar.gz"
  source_sha256 '0ae5bb9175dc0a602fe85c1cf591ac47ee5247b87f2bf164c16b05f87cbfa81a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvncserver/0.9.13-1_armv7l/libvncserver-0.9.13-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvncserver/0.9.13-1_armv7l/libvncserver-0.9.13-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvncserver/0.9.13-1_i686/libvncserver-0.9.13-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvncserver/0.9.13-1_x86_64/libvncserver-0.9.13-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9f15001e3b78ae2c74e56c063d6a9356589962d4263abc2f07863b0087c7062a',
     armv7l: '9f15001e3b78ae2c74e56c063d6a9356589962d4263abc2f07863b0087c7062a',
       i686: '988abec4fef7cdb9a74d04ed3d48a301aaf82b1d7e5ffde3b02ff8180673cb3b',
     x86_64: 'fe53c944159928ab225eb96ebb2f099037a64550d57c6ae61667cb817a183e5f'
  })

  depends_on 'ffmpeg'
  depends_on 'gtk2'
  depends_on 'libjpeg'
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libgcrypt' # R
  depends_on 'libpng' # R
  depends_on 'lzo' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

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
