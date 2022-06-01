require 'package'

class Gparted < Package
  description 'A Partition Magic clone, frontend to GNU Parted'
  homepage 'https://gparted.org/'
  @_ver = '1.4.0'
  version @_ver
  license 'GPL-2+ and FDL-1.2+'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/gparted/gparted/gparted-#{@_ver}/gparted-#{@_ver}.tar.gz"
  source_sha256 'e5293a792e53fdbeba29c4a834113cd9603d0d639330da931a468bf3687887be'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.4.0_armv7l/gparted-1.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.4.0_armv7l/gparted-1.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.4.0_i686/gparted-1.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.4.0_x86_64/gparted-1.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '789aedda96b2cd62cc48460b638af8f94b3cb2773ca6bc0a7d009ad109d94f4f',
     armv7l: '789aedda96b2cd62cc48460b638af8f94b3cb2773ca6bc0a7d009ad109d94f4f',
       i686: '59716f3f302de5e7134c51a97329083a0f325c59f5e796a94f79825e2e0601de',
     x86_64: '4d74f091eb9ce93c896f18784bbe715c0f300f2a15d04c9e7fb659651932a216'
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
  patchelf

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --sbindir=#{CREW_PREFIX}/bin \
      --enable-online-resize \
      --enable-libparted-dmraid \
      --enable-xhost-root"
    system 'make'
    system "cat <<'EOF'> gparted_
#!/bin/sh
xhost si:localuser:root
sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} gparted.elf
EOF"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/gparted", "#{CREW_DEST_PREFIX}/bin/gparted.elf"
    FileUtils.install 'gparted_', "#{CREW_DEST_PREFIX}/bin/gparted", mode: 0o755
  end
end
