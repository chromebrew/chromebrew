require 'package'

class Gusb < Package
  description 'LibGUsb is a GObject wrapper for libusb1'
  homepage 'https://www.openhub.net/p/gusb'
  version '0.3.5'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://github.com/hughsie/libgusb/archive/#{version}.tar.gz"
  source_sha256 '188c7964422417d39b02a5c645e136b1389c80e38e7abfa911fc196b9c748f45'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gusb/0.3.5_armv7l/gusb-0.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gusb/0.3.5_armv7l/gusb-0.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gusb/0.3.5_i686/gusb-0.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gusb/0.3.5_x86_64/gusb-0.3.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '57ca56f4b7f50e7365d47bd7296d162ee24d0983894c838d2a4e0191902f8537',
     armv7l: '57ca56f4b7f50e7365d47bd7296d162ee24d0983894c838d2a4e0191902f8537',
       i686: '90abb8dce0577287d373178ded6be2fd200270a4513a4f2fb028f7475b133a71',
     x86_64: '90a04122895b2567cd67751e63c59e1b39c934c1b1e7c6d604a73b8e17444f20'
  })

  depends_on 'gtk_doc'
  depends_on 'libusb'
  depends_on 'usbutils'
  depends_on 'gobject_introspection'

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto=auto/g' meson.build"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dc_args='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dc_link_args='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dcpp_args='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dcpp_link_args='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
    -Dusb_ids=#{CREW_PREFIX}/share/hwdata/usb.ids \
    -Ddocs=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
