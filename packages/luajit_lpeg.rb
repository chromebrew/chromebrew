# Adapted from Arch Linux lpeg PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lpeg/trunk/PKGBUILD

require 'package'

class Luajit_lpeg < Package
  description 'Pattern-matching library for Lua 5.1'
  homepage 'https://www.inf.puc-rio.br/~roberto/lpeg/'
  version '1.1.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.inf.puc-rio.br/~roberto/lpeg/lpeg-#{version}.tar.gz"
  source_sha256 '48d66576051b6c78388faad09b70493093264588fcd0f258ddaab1cdd4a15ffe'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30f01887109846f1d965e860c6668af5b17e8f3be805990931e993f563db33ba',
     armv7l: '30f01887109846f1d965e860c6668af5b17e8f3be805990931e993f563db33ba',
       i686: '059d7995b66de17743c9c7548e541372a5552f601faccc3b7e208629dc2e7ea1',
     x86_64: '04d8106e20b3718624648fa965a405fe4e5628a6d9e7be553bcb14ad12d446b0'
  })

  depends_on 'glibc' # R
  depends_on 'luajit' # R

  def self.patch
    @lua_cflags = `pkg-config --cflags luajit`.chomp
    system "sed -i 's,-I\$(LUADIR),#{@lua_cflags},g' makefile"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} LUA=#{CREW_PREFIX}/bin/luajit"
  end

  def self.install
    @lua_version = `luajit -e "print(_VERSION)" | awk '{print $2}'`.chomp
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}"
    FileUtils.install 'lpeg.so', "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/lpeg.so", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/lua/#{@lua_version}"
    FileUtils.install 're.lua', "#{CREW_DEST_PREFIX}/share/lua/#{@lua_version}", mode: 0o644
  end
end
