require 'package'

class Folks < Package
  description 'Library to aggregates people into metacontacts'
  homepage 'https://wiki.gnome.org/Projects/Folks'
  version '0.15.5'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/folks/-/archive/#{version}/folks-#{version}.tar.bz2"
  source_sha256 'f79952f6b0c8f6c0fa2efefbcfc4d4875a2ee5e4518f7d4bf520b62b5c89568c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/folks/0.15.5_armv7l/folks-0.15.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/folks/0.15.5_armv7l/folks-0.15.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/folks/0.15.5_i686/folks-0.15.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/folks/0.15.5_x86_64/folks-0.15.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2999307030aa76fb2e9ee4aaf52d83ae0835829d8d14c16af03f88efab8bda16',
     armv7l: '2999307030aa76fb2e9ee4aaf52d83ae0835829d8d14c16af03f88efab8bda16',
       i686: 'df9800ddea6eb9a6e0056d87f3af74a7212c519db9b57ac85625ea7511e5c6cc',
     x86_64: '8d5447fdd889e1f45f4f7178db791b0ff5fd7c5d7eac854872b43de36e44df4f'
  })

  depends_on 'libgee'
  depends_on 'evolution_data_server'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'readline' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbluez_backend=false \
    -Ddocs=false \
    -Deds_backend=false \
    -Dinstalled_tests=false \
    -Dofono_backend=false \
    -Dtelepathy_backend=false \
    -Dtests=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
