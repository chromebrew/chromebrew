require 'package'

class Gparted < Package
  description 'A Partition Magic clone, frontend to GNU Parted'
  homepage 'https://gparted.org/'
  version '1.5.0'
  license 'GPL-2+ and FDL-1.2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url "https://downloads.sourceforge.net/project/gparted/gparted/gparted-#{version}/gparted-#{version}.tar.gz"
  source_sha256 '3c95ea26a944083ff1d9b17639b1e2ad9758df225dc751ff407b2a6aa092a8de'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.5.0_armv7l/gparted-1.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.5.0_armv7l/gparted-1.5.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.5.0_x86_64/gparted-1.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f4365811ad6f720bd9a3faf834634f5776cdd3921f093e63f014a675cc31b371',
     armv7l: 'f4365811ad6f720bd9a3faf834634f5776cdd3921f093e63f014a675cc31b371',
     x86_64: '8a3230702da1f1f1f780bdc24085fc35f5f2a70404ad9fd0b41a19946486607f'
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
