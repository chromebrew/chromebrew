# Adapted from Arch Linux nmap PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nmap/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nmap < Autotools
  description 'Utility for network discovery and security auditing'
  homepage 'https://nmap.org/'
  version '7.993'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://nmap.org/dist/nmap-#{version}.tar.bz2"
  source_sha256 '270e55f04915bfcecb5db8feb959d4c5ba86a48c094520a4f1c07571e1c79c59'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0108f7e8a99bc1b9cf5e99d45fae7736fb6bdfa1d6326066b80bf8916379e23c',
     armv7l: '0108f7e8a99bc1b9cf5e99d45fae7736fb6bdfa1d6326066b80bf8916379e23c',
     x86_64: '352cc10a4abe9fb71f92b7d0e19f429439a562ff964ad724cc4ec51ead8590e8'
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
