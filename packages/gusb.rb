require 'package'

class Gusb < Package
  description 'LibGUsb is a GObject wrapper for libusb1'
  homepage 'https://openhub.net/p/gusb'
  version '0.4.9'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/hughsie/libgusb/archive/#{version}.tar.gz"
  source_sha256 'aa1242a308183d4ca6c2e8c9e3f2e345370b94308ef2d4b6e9c10d5ff6d7763e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b99ce734c9d84f9eca203d542eba3e7c9150914e8a5f7401d317d8523d06a6f',
     armv7l: '0b99ce734c9d84f9eca203d542eba3e7c9150914e8a5f7401d317d8523d06a6f',
       i686: '90abb8dce0577287d373178ded6be2fd200270a4513a4f2fb028f7475b133a71',
     x86_64: '0e1fa06ae6eb1f2dc198d248e7c46da259935206852f074358e545c43f33722c'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'json_glib' # R
  depends_on 'libusb' # R
  depends_on 'usbutils'
  depends_on 'vala'

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
