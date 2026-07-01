require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.5.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.lua.org/ftp/lua-#{version}.tar.gz"
  source_sha256 '57ccc32bbbd005cab75bcc52444052535af691789dba2b9016d5c50640d68b3d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b0805afccdcd164c9f49fcd7b4c8e39360a3572612b77819f72f8dd7c7f5424',
     armv7l: '6b0805afccdcd164c9f49fcd7b4c8e39360a3572612b77819f72f8dd7c7f5424',
       i686: '34eefb9638a5d81e558b8f5a70713763b84b090e26ed87600aa530437ae73cda',
     x86_64: 'c14840760a3ffaa82fefc67de457e13bb48d82b47c2a9b38b58d0ef4b5f03d49'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'readline' => :executable

  def self.patch
    patch = [
      [
        # Patch to build shared library.
        'https://gitlab.archlinux.org/archlinux/packaging/packages/lua/-/raw/main/liblua.so.patch',
        '644fba6f3e03c4d0c394d241149fc558da79d0114e7816c2a597097304249cb7'
      ]
    ]
    ConvenienceFunctions.patch(patch)
  end

  def self.build
    system "make MYCFLAGS='-fPIC' -j#{CREW_NPROC}"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} \
            INSTALL_LIB=#{CREW_DEST_LIB_PREFIX} \
            INSTALL_MAN=#{CREW_DEST_MAN_PREFIX}/man1 \
            INSTALL_TOP=#{CREW_DEST_PREFIX} \
            INSTALL_DATA='cp -d' \
            install"
    Dir['src/liblua.so*'].each do |library|
      lib = File.basename(library)
      FileUtils.install library, "#{CREW_DEST_LIB_PREFIX}/#{lib}", mode: 0o644
    end
    downloader 'https://gitlab.archlinux.org/archlinux/packaging/packages/lua/-/blob/main/lua.pc',
               'f3bf1920217b17f351103b104d6cc7d5375d6dcdd9126c061986d4b88f87c9c6'
    FileUtils.install 'lua.pc', "#{CREW_DEST_LIB_PREFIX}/pkgconfig/lua.pc", mode: 0o644
  end
end
