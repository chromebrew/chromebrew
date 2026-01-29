require 'package'

class Gparted < Package
  description 'A Partition Magic clone, frontend to GNU Parted'
  homepage 'https://gparted.org/'
  version '1.8.0'
  license 'GPL-2+ and FDL-1.2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/gparted/gparted/gparted-#{version}/gparted-#{version}.tar.gz"
  source_sha256 'f584ed4be7fd09c2cf6a784778a8540970d985f0ac8e5a7bd0628528a3ab5609'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1c380b9e4b25dd5e73380935788f521011703af1a6dbb1ae3a1c53f80ff09f3',
     armv7l: 'e1c380b9e4b25dd5e73380935788f521011703af1a6dbb1ae3a1c53f80ff09f3',
     x86_64: '0df67181929dd5f02c1a682042b6a8117538365e26c03bfd48abbbc32f68f4cb'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'atkmm16' # R
  depends_on 'cairo' # R
  depends_on 'cairomm_1_0' # R
  depends_on 'exfatprogs'
  depends_on 'f2fs_tools'
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'gpart'
  depends_on 'gtk3' # R
  depends_on 'gtkmm3'
  depends_on 'harfbuzz' # R
  depends_on 'intltool' => :build
  depends_on 'librsvg'
  depends_on 'libsigcplusplus'
  depends_on 'libsigcplusplus2' # R
  depends_on 'mtools'
  depends_on 'pango' # R
  depends_on 'pangomm_1_4' # R
  depends_on 'parted'
  depends_on 'py3_itstool' => :build
  depends_on 'sommelier' => :logical
  depends_on 'util_linux' # R
  depends_on 'xfsprogs'
  depends_on 'xhost'
  depends_on 'yelp_tools' => :build
  depends_on 'zlib' # R

  def self.patch
    system 'filefix' # Fix ./configure: line 7001: /usr/bin/file: No such file or directory
  end

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
      --sbindir=#{CREW_PREFIX}/bin \
      --enable-online-resize \
      --enable-libparted-dmraid \
      --enable-xhost-root"
    system 'make'
    gparted_sh = <<~EOF
      #!/bin/sh
      xhost si:localuser:root
      sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} #{CREW_PREFIX}/bin/gparted.elf
    EOF
    File.write('gparted.sh', gparted_sh)
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/gparted", "#{CREW_DEST_PREFIX}/bin/gparted.elf"
    FileUtils.install 'gparted.sh', "#{CREW_DEST_PREFIX}/bin/gparted", mode: 0o755
  end
end
