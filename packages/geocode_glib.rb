require 'package'

class Geocode_glib < Package
  description 'Helper library for geocoding services'
  homepage 'https://gitlab.gnome.org/GNOME/geocode-glib'
  version '3.26.4'
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://github.com/GNOME/geocode-glib/archive/3.26.4.tar.gz'
  source_sha256 'cd4464f74add58584f04e6a7f16347f07caf271509e0b7ef067a4170b74518c9'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geocode_glib/3.26.4_armv7l/geocode_glib-3.26.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geocode_glib/3.26.4_armv7l/geocode_glib-3.26.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geocode_glib/3.26.4_i686/geocode_glib-3.26.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geocode_glib/3.26.4_x86_64/geocode_glib-3.26.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b4c19b4b56d86ca0ce4d5a98f0b87f09ba883e5363e271277c0419a72ece6fa3',
     armv7l: 'b4c19b4b56d86ca0ce4d5a98f0b87f09ba883e5363e271277c0419a72ece6fa3',
       i686: 'dcdf9e3856df49de22b152614b63192c9ea9456e3cbb5698933cf85a608c4120',
     x86_64: '7149daebea7923591edbabf59b14e328421880aaac8c8147ba4ac0c0838b5d19'
  })

  depends_on 'json_glib'
  depends_on 'libsoup'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libsoup2' # R

  def self.patch
    system "sed -i 's/gnome/Adwaita/' icons/meson.build"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
