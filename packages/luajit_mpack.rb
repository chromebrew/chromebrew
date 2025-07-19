# Adapted from Arch Linux lua-mpack PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lua-mpack/trunk/PKGBUILD

require 'package'

class Luajit_mpack < Package
  description 'libmpack lua binding'
  homepage 'https://github.com/libmpack/libmpack-lua'
  version '1.0.12'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/libmpack/libmpack-lua/archive/#{version}.tar.gz"
  source_sha256 'e94d5cf95d7479dca00ff23755fe05a440f11f9d203635e862ad8842de95f40a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b6f8218fd08f132ac9e61263385568137ca84c5d777df66234bf5b5d48844f6',
     armv7l: '8b6f8218fd08f132ac9e61263385568137ca84c5d777df66234bf5b5d48844f6',
       i686: 'c9edc78efa3a1fdc7381757f005c00efa526b9824ee77f22ab672d5655b8207b',
     x86_64: '1ec31e6bf82f6268f31527e35ebed117731489d05356f0ab3bedb091e2bd9028'
  })

  depends_on 'glibc' # R
  depends_on 'libmpack' # R
  depends_on 'luajit' # R

  def self.build
    system "#{CREW_ENV_OPTIONS} make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} LUA=#{CREW_PREFIX}/bin/luajit USE_SYSTEM_LUA=yes LUA_INCLUDE=`pkg-config --cflags luajit`"
  end

  def self.install
    @lua_version = `luajit -e "print(_VERSION)" | awk '{print $2}'`.chomp
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}"
    FileUtils.install 'mpack.so', "#{CREW_DEST_PREFIX}/lib/lua/#{@lua_version}/mpack.so", mode: 0o755
  end
end
