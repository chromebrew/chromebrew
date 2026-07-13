# Adapted from Arch Linux nmap PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nmap/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nmap < Autotools
  description 'Utility for network discovery and security auditing'
  homepage 'https://nmap.org/'
  version '7.99'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://nmap.org/dist/nmap-#{version}.tar.bz2"
  source_sha256 'df512492ffd108e53a27a06f26d8635bbe89e0e569455dc8ffef058c035d51b2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5490359e88b56430b60a59f4c45b929e38d69a3b8b0595042557e5b5ec264f84',
     armv7l: '5490359e88b56430b60a59f4c45b929e38d69a3b8b0595042557e5b5ec264f84',
     x86_64: 'd58f72d2f005ea01ba0f2f9b38f0c6707dda6baadfb6240ebb04e4a8aa0724da'
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
