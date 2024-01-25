# Adapted from Arch Linux lua-lgi-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=lua-lgi-git

require 'package'

class Luajit_lgi < Package
  description 'Lua bindings for gnome/gobject using gobject-introspection library'
  homepage 'https://github.com/pavouk/lgi'
  version '0.9.2'
  license 'custom:MIT'
  compatibility 'all'
  source_url 'https://github.com/lgi-devs/lgi/archive/refs/tags/0.9.2.tar.gz'
  source_sha256 'cfc4105482b4730b3a40097c9d9e7e35c46df2fb255370bdeb2f45a886548c4f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e19655e9a947cf484f57a92c528fe58b830c53ebac0ef271e5a623c42c906982',
     armv7l: 'e19655e9a947cf484f57a92c528fe58b830c53ebac0ef271e5a623c42c906982',
       i686: 'ca6206e7ec462dd8d71caa64ec23cda3f6ac3a856f6deccbfb058f3244e06d12',
     x86_64: 'fb5ba8a94d24d9e129ad435304102571bfc785e753dfa34e88e4addd5869fbde'
  })

  depends_on 'cairo'
  depends_on 'glibc'
  depends_on 'glib'
  depends_on 'libffi'
  depends_on 'gobject_introspection'
  depends_on 'luajit'

  def self.build
    @lua_cflags = `pkg-config --cflags luajit`.chomp
    @lua_include = `pkg-config --cflags-only-I luajit | sed 's/-I//'`.chomp
    system "make LUA_INCDIR=#{@lua_include} \
       LUA_CFLAGS=#{@lua_cflags}"
    # system "meson setup #{CREW_MESON_OPTIONS} \
    #-Dlua-pc=luajit \
    #-Dlua-bin=#{CREW_PREFIX}/bin/luajit \
    #-Dtests=false \
    # builddir"
    # system 'meson configure --no-pager builddir'
    # system 'mold -run samu -C builddir'
  end

  def self.install
    @lua_version = `luajit -e "print(_VERSION)" | awk '{print $2}'`.chomp
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/lgi"
    system "make \
    LUA_LIBDIR=#{CREW_PREFIX}/lib/lua/#{@lua_version} \
    LUA_SHAREDIR=#{CREW_PREFIX}/share/lua/#{@lua_version} \
    DESTDIR=#{CREW_DEST_DIR} install"
    # return unless ARCH == 'x86_64'

    # FileUtils.mv "#{CREW_DEST_LIB_PREFIX}/lua/#{@lua_version}/lgi/corelgilua51.so",
    #             "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/lgi/corelgilua51.so"
  end
end
