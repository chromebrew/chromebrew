# Adapted from Arch Linux lua-lgi-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=lua-lgi-git

require 'package'

class Luajit_lgi < Package
  description 'Lua bindings for gnome/gobject using gobject-introspection library'
  homepage 'https://github.com/pavouk/lgi'
  version '0.9.2-34fe0e2'
  license 'custom:MIT'
  compatibility 'all'
  source_url 'https://github.com/lgi-devs/lgi/archive/34fe0e2470429be11fc7268a9391ee715b3377e0.zip'
  source_sha256 'f0076a2652c0f0057e9f62d3ea2edb51cf5680844162d93912c47461c66d3243'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit_lgi/0.9.2-34fe0e2_armv7l/luajit_lgi-0.9.2-34fe0e2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit_lgi/0.9.2-34fe0e2_armv7l/luajit_lgi-0.9.2-34fe0e2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit_lgi/0.9.2-34fe0e2_i686/luajit_lgi-0.9.2-34fe0e2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit_lgi/0.9.2-34fe0e2_x86_64/luajit_lgi-0.9.2-34fe0e2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b9c28200a459766c0688765b240402bae057313117e3d4ef232bff6dc8cbaef3',
     armv7l: 'b9c28200a459766c0688765b240402bae057313117e3d4ef232bff6dc8cbaef3',
       i686: '8925c8bd0e256cd1f57041b320f22868f60d670b066f4c477376bb123766b037',
     x86_64: '810db53f6eedff005c6dc67cb047a4e900c9c3515f8bf710235016b7c526774f'
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
    @lua_version = `luajit -e "print(_VERSION)" | awk '{print $2}'`.chomp
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/lgi"
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    return unless ARCH == 'x86_64'

    FileUtils.mv "#{CREW_DEST_LIB_PREFIX}/lua/#{@lua_version}/lgi/corelgilua51.so",
                 "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/lgi/corelgilua51.so"
  end
end
