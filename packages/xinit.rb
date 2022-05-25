require 'package'

class Xinit < Package
  description 'The xinit package contains a usable script to start the xserver.'
  homepage 'https://www.x.org'
  version '1.4.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/app/xinit-1.4.2.tar.gz'
  source_sha256 '9121c9162f6dedab1229a8c4ed4021c4d605699cb0da580ac2ee1b0c96b3f60e'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xinit/1.4.2_armv7l/xinit-1.4.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xinit/1.4.2_armv7l/xinit-1.4.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xinit/1.4.2_i686/xinit-1.4.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xinit/1.4.2_x86_64/xinit-1.4.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '23c169a3f7662628d1ee072ddb5e9275705d4625f7a32dc97addea86d2221140',
     armv7l: '23c169a3f7662628d1ee072ddb5e9275705d4625f7a32dc97addea86d2221140',
       i686: '49ac02da27403934e28dff71b7cb3d4a6784f3bd2759b7585bd34588f0307e00',
     x86_64: '39b6cdc11b9bbef6850969fa9f9d1e445b5eee7f377658927818b371d4928dc0'
  })

  depends_on 'xauth' # L
  depends_on 'xterm' # L
  depends_on 'glibc' # R
  depends_on 'libx11' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
