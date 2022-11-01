require 'package'

class Libfontenc < Package
  description 'Fontenc Library from X.org'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1.6'
  compatibility 'all'
  license 'custom'
  source_url 'https://www.x.org/releases/individual/lib/libfontenc-1.1.5.tar.xz'
  source_sha256 '43ef0387090ea526faf8d3b0907ee0e4be0fb433c17e0b1bdb8433aa1de2b12c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfontenc/1.1.4_armv7l/libfontenc-1.1.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfontenc/1.1.4_armv7l/libfontenc-1.1.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfontenc/1.1.4_x86_64/libfontenc-1.1.4-chromeos-x86_64.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfontenc/1.1.6_i686/libfontenc-1.1.6-chromeos-i686.tar.zst'
  })
  binary_sha256({
    aarch64: 'cf093d4545369715602df5d61ed7338a867bbe11a07a26ddcd563c95478c78c5',
     armv7l: 'cf093d4545369715602df5d61ed7338a867bbe11a07a26ddcd563c95478c78c5',
     x86_64: '08bc791449cfabb5833a5cbd7c35c541032bae3bf3f8755455935ec61fd815c4',
       i686: '8929d18ee367196ebaf989813abe51979929896d2f881e8775babe37a49ba65f'
  })

  depends_on 'xorg_proto'
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --with-fontrootdir=#{CREW_PREFIX}/share/fonts/X11"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
