require 'package'

class Meld < Package
  description 'Meld is a visual diff and merge tool targeted at developers.'
  homepage 'https://meldmerge.org/'
  version '3.22.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/meld/-/archive/3.22.0/meld-3.22.0.tar.gz'
  source_sha256 '6332dda01925a2ee367b4b2c50da9a89e040b6656f6643c4aae037c20690a8a2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meld/3.22.0_armv7l/meld-3.22.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meld/3.22.0_armv7l/meld-3.22.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meld/3.22.0_i686/meld-3.22.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meld/3.22.0_x86_64/meld-3.22.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '41addb40a83c9994b929eb2279f4a2ba1a9daca533ffb716a7e0e78010397061',
     armv7l: '41addb40a83c9994b929eb2279f4a2ba1a9daca533ffb716a7e0e78010397061',
       i686: '738c8fe2c1df886e38587f69dddaecb928d615e19233ccc5c4fdb83f8c552478',
     x86_64: 'f3c5aa6aab0cde154c79bc8d9d860b1851ea760cb54d0ff31a1df9f91d9ed1a9'
  })

  depends_on 'gtk3'
  depends_on 'gtksourceview_4'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
