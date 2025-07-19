# Adapted from Arch Linux lua-bitop PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lua-bitop/trunk/PKGBUILD

require 'package'

class Luajit_bitop < Package
  description 'Bitwise operations on numbers'
  homepage 'https://bitop.luajit.org/'
  version '1.0.3'
  license 'MIT'
  compatibility 'all'
  source_url "https://bitop.luajit.org/download/LuaBitOp-#{version}.tar.gz"
  source_sha256 '1207c9293dcd52eb9dca6538d1b87352bd510f4e760938f5048433f7f272ce99'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02a587481cb2abf46b1591bdb0e8b5c1fe1275433b298b1ff6422a4b6d92025b',
     armv7l: '02a587481cb2abf46b1591bdb0e8b5c1fe1275433b298b1ff6422a4b6d92025b',
       i686: 'b031ee38b7dc2a5ecad5ddde25b740f6c3edda14b103af434fd0e103fc407087',
     x86_64: '8476b56a01f3f93cc9d4d2843dc926197ba2e70da802d4cbdbd626021ad33bb7'
  })

  depends_on 'glibc' # R
  depends_on 'luajit' # R

  def self.patch
    system "sed -i 's,LUA= lua,LUA= luajit,g' Makefile"
    @lua_cflags = `pkg-config --cflags luajit`.chomp
    system "sed -i 's,-I/usr/local/include,#{@lua_cflags},g' Makefile"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} LUA=#{CREW_PREFIX}/bin/luajit"
  end

  def self.install
    @lua_version = `luajit -e "print(_VERSION)" | awk '{print $2}'`.chomp
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}"
    FileUtils.install 'bit.so', "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/bit.so", mode: 0o755
  end
end
