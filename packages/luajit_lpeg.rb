# Adapted from Arch Linux lpeg PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lpeg/trunk/PKGBUILD

require 'package'

class Luajit_lpeg < Package
  description 'Pattern-matching library for Lua 5.1'
  homepage 'http://www.inf.puc-rio.br/~roberto/lpeg'
  version '1.0.2'
  license 'MIT'
  compatibility 'all'
  source_url 'http://www.inf.puc-rio.br/~roberto/lpeg/lpeg-1.0.2.tar.gz'
  source_sha256 '48d66576051b6c78388faad09b70493093264588fcd0f258ddaab1cdd4a15ffe'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8e6f79a92c8d8c5bc189088bda5de3816d25bfde61538a7189ff8b90ba72363',
     armv7l: 'd8e6f79a92c8d8c5bc189088bda5de3816d25bfde61538a7189ff8b90ba72363',
       i686: '64ee5bb516995be8456dd8795eda03093d13317f391bb4dfe8682fb2a2520daa',
     x86_64: '26842c281045e696a7476cc2f659a38e5e25db3ce5606ce05e27c2bd95934594'
  })

  depends_on 'luajit'

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
