require 'package'

class Gparted < Package
  description 'A Partition Magic clone, frontend to GNU Parted'
  homepage 'https://gparted.org/'
  version '1.6.0'
  license 'GPL-2+ and FDL-1.2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url "https://downloads.sourceforge.net/project/gparted/gparted/gparted-#{version}/gparted-#{version}.tar.gz"
  source_sha256 '9b9f51b3ce494ddcb59a55e1ae6679c09436604e331dbf5a536d60ded6c6ea5b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '388d06914e3552ef44866067599caf5de1d3ee2584abd2f8be3c00c0864f7773',
     armv7l: '388d06914e3552ef44866067599caf5de1d3ee2584abd2f8be3c00c0864f7773',
     x86_64: '1b8f2885bc04c372c22194966e8ca11bf042da297d2c732f5d6db88f1250e4b9'
  })

  depends_on 'parted'
  depends_on 'gtkmm3'
  depends_on 'intltool' => :build
  depends_on 'itstool' => :build
  depends_on 'yelp_tools' => :build
  depends_on 'xfsprogs'
  depends_on 'exfatprogs'
  depends_on 'f2fs_tools'
  depends_on 'gpart'
  depends_on 'mtools'
  depends_on 'libsigcplusplus'
  depends_on 'librsvg'
  depends_on 'xhost'
  depends_on 'sommelier'

  def self.patch
    system 'filefix' # Fix ./configure: line 7001: /usr/bin/file: No such file or directory
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
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
