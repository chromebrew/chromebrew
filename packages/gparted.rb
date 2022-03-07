require 'package'

class Gparted < Package
  description 'A Partition Magic clone, frontend to GNU Parted'
  homepage 'https://gparted.org/'
  @_ver = '1.3.1'
  version @_ver
  license 'GPL-2+ and FDL-1.2+'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/gparted/gparted/gparted-#{@_ver}/gparted-#{@_ver}.tar.gz"
  source_sha256 '5eee2e6d74b15ef96b13b3a2310c868ed2298e03341021e7d12a5a98a1d1e109'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.3.1_armv7l/gparted-1.3.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.3.1_armv7l/gparted-1.3.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.3.1_i686/gparted-1.3.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gparted/1.3.1_x86_64/gparted-1.3.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9036f953c9fa9d23d4a1214c853a3c16ca995f4b5b31b8850cf4c83ff346ce35',
     armv7l: '9036f953c9fa9d23d4a1214c853a3c16ca995f4b5b31b8850cf4c83ff346ce35',
       i686: '570508eb7d9f970540a0160cd616ee49ed5554c24e378d1b3f89ba8616a4ee04',
     x86_64: 'ed4c39343af25733424d215b8eeb51674371afb34d627829ae627e89d35b4a34'
  })

  depends_on 'parted'
  depends_on 'gtkmm3'
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
