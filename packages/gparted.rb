require 'package'

class Gparted < Package
  description 'A Partition Magic clone, frontend to GNU Parted'
  homepage 'https://gparted.org/'
  version '1.8.1'
  license 'GPL-2+ and FDL-1.2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/gparted/gparted/gparted-#{version}/gparted-#{version}.tar.gz"
  source_sha256 '67388ac405f9fe92a40636cb03b0e1e0bb6403ad89ccc174b2ff190ef6f32349'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d8d5d77a36531fde85ecba4f084463b921a40855a442485eb9f340c0139d3fe',
     armv7l: '8d8d5d77a36531fde85ecba4f084463b921a40855a442485eb9f340c0139d3fe',
     x86_64: 'fab804cf579892b2660dc7eb115d2c9852425b3e6d726fc9247f88698c169613'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'at_spi2_core' => :executable_only
  depends_on 'atkmm16' => :executable
  depends_on 'atkmm16' => :executable_only
  depends_on 'cairo' => :executable
  depends_on 'cairo' => :executable_only
  depends_on 'cairomm_1_0' => :executable
  depends_on 'cairomm_1_0' => :executable_only
  depends_on 'exfatprogs'
  depends_on 'f2fs_tools'
  depends_on 'gcc_lib' => :executable
  depends_on 'gcc_lib' => :executable_only
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'gdk_pixbuf' => :executable_only
  depends_on 'glib' => :executable
  depends_on 'glib' => :executable_only
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :executable_only
  depends_on 'glibmm_2_4' => :executable
  depends_on 'glibmm_2_4' => :executable_only
  depends_on 'gpart'
  depends_on 'gtk3' => :executable
  depends_on 'gtk3' => :executable_only
  depends_on 'gtkmm3' => :executable
  depends_on 'gtkmm3' => :executable_only
  depends_on 'harfbuzz' => :executable
  depends_on 'harfbuzz' => :executable_only
  depends_on 'intltool' => :build
  depends_on 'librsvg'
  depends_on 'libsigcplusplus'
  depends_on 'libsigcplusplus2' => :executable
  depends_on 'libsigcplusplus2' => :executable_only
  depends_on 'mtools'
  depends_on 'pango' => :executable
  depends_on 'pango' => :executable_only
  depends_on 'pangomm_1_4' => :executable
  depends_on 'pangomm_1_4' => :executable_only
  depends_on 'parted' => :executable
  depends_on 'parted' => :executable_only
  depends_on 'py3_itstool' => :build
  depends_on 'sommelier' => :logical
  depends_on 'util_linux' => :executable
  depends_on 'util_linux' => :executable_only
  depends_on 'xfsprogs'
  depends_on 'xhost'
  depends_on 'yelp_tools' => :build
  depends_on 'zlib' => :executable
  depends_on 'zlib' => :executable_only

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
