require 'package'

class Libmfx < Package
  description 'Intel Media SDK dispatcher library'
  homepage 'https://github.com/lu-zero/mfx_dispatch/'
  version '1.35.1'
  license 'BSD'
  compatibility 'i686'
  source_url 'https://github.com/lu-zero/mfx_dispatch/archive/1.35.1.tar.gz'
  source_sha256 '673636da98a4fd5c3e3dc5267da5429e986f53089ed6c33cdca5751f56d9416b'
  binary_compression 'tar.zst'

  binary_sha256({
    i686: '3491a2615abbe06c01ad6c6d17721f56415190068a899f6a7195de0ccbaac3ef'
  })

  depends_on 'libva'

  def self.build
    system 'autoreconf -i'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared='yes' \
      --with-libva_drm='yes' \
      --with-libva_x11='yes' \
      --with-pic"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    # fix version in pkg-config file"
    system "sed -i /Version:/s/[0-9]\.[0-9]\{2\}/#{version}/ #{CREW_DEST_LIB_PREFIX}/pkgconfig/libmfx.pc"
  end
end
