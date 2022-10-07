# Adapted from Arch Linux lua-lgi-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=lua-lgi-git

require 'package'

class Lua_lgi < Package
  description 'Lua bindings for gnome/gobject using gobject-introspection library'
  homepage 'https://github.com/pavouk/lgi'
  version '0.9.2-34fe0e2'
  license 'custom:MIT'
  compatibility 'all'
  source_url 'https://github.com/lgi-devs/lgi/archive/34fe0e2470429be11fc7268a9391ee715b3377e0.zip'
  source_sha256 'f0076a2652c0f0057e9f62d3ea2edb51cf5680844162d93912c47461c66d3243'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua_lgi/0.9.2-34fe0e2_armv7l/lua_lgi-0.9.2-34fe0e2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua_lgi/0.9.2-34fe0e2_armv7l/lua_lgi-0.9.2-34fe0e2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua_lgi/0.9.2-34fe0e2_i686/lua_lgi-0.9.2-34fe0e2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua_lgi/0.9.2-34fe0e2_x86_64/lua_lgi-0.9.2-34fe0e2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c4a069c9f18343c22444095a5c3235639039f716b3ce13e7f6385fb161850c2f',
     armv7l: 'c4a069c9f18343c22444095a5c3235639039f716b3ce13e7f6385fb161850c2f',
       i686: '311225a4da7df697173c95a9fe083784fc50696db93dddaf90ce6bf9dac26671',
     x86_64: 'c39d4a78763e193256fcfee906aca9c7909c500fc18f38439c25faab0b6fdd60'
  })

  depends_on 'cairo'
  depends_on 'glibc'
  depends_on 'glib'
  depends_on 'libffi'
  depends_on 'gobject_introspection'
  depends_on 'luajit'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dlua-pc=luajit \
      -Dlua-bin=#{CREW_PREFIX}/bin/luajit \
      -Dtests=false \
      builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
