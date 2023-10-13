require 'package'

class Dconf < Package
  description 'The DConf package contains a low-level configuration system.'
  homepage 'https://wiki.gnome.org/Projects/dconf'
  version '0.40.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.rc/sources/dconf-0.40.0.tar.xz'
  source_sha256 'cf7f22a4c9200421d8d3325c5c1b8b93a36843650c9f95d6451e20f0bcb24533'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dconf/0.40.0_armv7l/dconf-0.40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dconf/0.40.0_armv7l/dconf-0.40.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dconf/0.40.0_i686/dconf-0.40.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dconf/0.40.0_x86_64/dconf-0.40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2d1df99cdc3536a8e44f679c78adcb54030c2dc84fc806da32f68f49172960b4',
     armv7l: '2d1df99cdc3536a8e44f679c78adcb54030c2dc84fc806da32f68f49172960b4',
       i686: '1f17e19357695ff97dbe37aba82c5a3c40b138bba6e2acb18986b103e3d8832a',
     x86_64: '4362ea8fa70e02799dc148f97891c30787f311ebfda78ccf0966d3843b9dc173'
  })

  depends_on 'dbus' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib'
  depends_on 'vala' => :build
  depends_on 'bash_completion' => :build

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
