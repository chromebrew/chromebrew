# Adapted from Arch Linux lua-mpack PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lua-mpack/trunk/PKGBUILD

require 'package'

class Luajit_mpack < Package
  description 'libmpack lua binding'
  homepage 'https://github.com/libmpack/libmpack-lua'
  version '1.0.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libmpack/libmpack-lua/archive/1.0.9.tar.gz'
  source_sha256 'e94d5cf95d7479dca00ff23755fe05a440f11f9d203635e862ad8842de95f40a'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit_mpack/1.0.9_armv7l/luajit_mpack-1.0.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit_mpack/1.0.9_armv7l/luajit_mpack-1.0.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit_mpack/1.0.9_i686/luajit_mpack-1.0.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/luajit_mpack/1.0.9_x86_64/luajit_mpack-1.0.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1be27ef45bfaf01f91a0be5ff9a4515224176a0c480bc1b475b4ab9e2519f46b',
     armv7l: '1be27ef45bfaf01f91a0be5ff9a4515224176a0c480bc1b475b4ab9e2519f46b',
       i686: '86fb45f1d5eb2ed5edb9bd291bf05f4d58730007e6adb067d544a26feb01bf3e',
     x86_64: '4f23373e477afd0e99dc27cce8bbb8340478f98b1a96b30cdc43740523d11422'
  })

  depends_on 'libmpack'
  depends_on 'luajit' => :build

  def self.build
    system "#{CREW_ENV_OPTIONS} make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} LUA=#{CREW_PREFIX}/bin/luajit USE_SYSTEM_LUA=yes LUA_INCLUDE=`pkg-config --cflags luajit`"
  end

  def self.install
    @lua_version = `luajit -e "print(_VERSION)" | awk '{print $2}'`.chomp
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}"
    FileUtils.install 'mpack.so', "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/mpack.so", mode: 0o755
  end
end
