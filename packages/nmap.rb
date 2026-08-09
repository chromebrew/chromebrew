# Adapted from Arch Linux nmap PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nmap/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nmap < Autotools
  description 'Utility for network discovery and security auditing'
  homepage 'https://nmap.org/'
  version '7.991'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://nmap.org/dist/nmap-#{version}.tar.bz2"
  source_sha256 'a5d507f29437bef3bedd4771ff9aaa8fc1c2a109ddba1f5b1cf12027456929be'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8aa330812813dc85cff8f41ceab948127999bd55f2d5590e0e28cb122a8290da',
     armv7l: '8aa330812813dc85cff8f41ceab948127999bd55f2d5590e0e28cb122a8290da',
     x86_64: '15051191f5dd28ed098ea2e7876e4185c77e1f258141c6362a8ec0a4f47c28b0'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :library
  depends_on 'libffi' => :library
  depends_on 'libpcap' => :executable
  depends_on 'libssh2' => :executable
  depends_on 'openssl' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'zlib' => :executable

  def self.patch
    # ensure we build "devendored deps"
    @deps = %w[libpcap libpcre macosx mwin32 libssh2 libz]
    @deps.each do |dep|
      FileUtils.rm_rf dep
    end
  end

  autotools_configure_options " \
    --with-libpcap=#{CREW_PREFIX} \
    --with-libpcre=#{CREW_PREFIX} \
    --with-zlib=#{CREW_PREFIX} \
    --with-libssh2=#{CREW_PREFIX} \
    --with-liblua=included \
    --without-ndiff"

  autotools_build_extras do
    File.write 'zenmap.sh', <<~ZENMAP_EOF
      #!/bin/sh
      xhost si:localuser:root
      sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} zenmap.elf "$@"
    ZENMAP_EOF
  end

  autotools_install_extras do
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/zenmap", "#{CREW_DEST_PREFIX}/bin/zenmap.elf"
    FileUtils.install 'zenmap.sh', "#{CREW_DEST_PREFIX}/bin/zenmap", mode: 0o755
  end
end
