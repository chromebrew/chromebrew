# Adapted from Arch Linux lua-mpack PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lua-mpack/trunk/PKGBUILD

require 'package'

class Luajit_mpack < Package
  description 'libmpack lua binding'
  homepage 'https://github.com/libmpack/libmpack-lua'
  version '1.0.13'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libmpack/libmpack-lua.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e420510b6e56f4207942d71b8fc9b4741228646245d21704028dcdb3a774d501',
     armv7l: 'e420510b6e56f4207942d71b8fc9b4741228646245d21704028dcdb3a774d501',
       i686: '752866fda63f61e7c799cebbc8885665e1334729b2a6f9dadf638fe50142b1a3',
     x86_64: 'a5c560c9c1af0b884d7478a0f54857422a980264701ddcee9473cad251d82321'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libmpack' => :library
  depends_on 'luajit' => :library

  def self.build
    system "#{CREW_ENV_OPTIONS} make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} LUA=#{CREW_PREFIX}/bin/luajit USE_SYSTEM_LUA=yes LUA_INCLUDE=`pkg-config --cflags luajit`"
  end

  def self.install
    @lua_version = `luajit -e "print(_VERSION)" | awk '{print $2}'`.chomp
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}"
    FileUtils.install 'mpack.so', "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/mpack.so", mode: 0o755
  end
end
