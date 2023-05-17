# Adapted from Arch Linux openh264 PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/openh264/trunk/PKGBUILD

require 'package'

class Openh264 < Package
  description 'H.264 encoder and decoder'
  homepage 'https://www.openh264.org/'
  version '2.3.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/cisco/openh264/archive/v2.3.1/openh264-2.3.1.tar.gz'
  source_sha256 '453afa66dacb560bc5fd0468aabee90c483741571bca820a39a1c07f0362dc32'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openh264/2.3.1_armv7l/openh264-2.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openh264/2.3.1_armv7l/openh264-2.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openh264/2.3.1_i686/openh264-2.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openh264/2.3.1_x86_64/openh264-2.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd25d54ea1cf05c529fbf86b54fe26a0b80be4cc424e3f4dcdf6e70c2af6c0283',
     armv7l: 'd25d54ea1cf05c529fbf86b54fe26a0b80be4cc424e3f4dcdf6e70c2af6c0283',
       i686: '37cb08ef667b57bdcb21391bd5e96ba78f080d3107a5d6044522a745b17e86cc',
     x86_64: '5a4dcecb3251a329c6b6539162e212fc4fb497159e98567208bc348bda5d579d'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'nasm' => :build

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Dtests=disabled \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
