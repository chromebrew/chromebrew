require 'package'

class Gparted < Package
  description 'A Partition Magic clone, frontend to GNU Parted'
  homepage 'https://gparted.org/'
  @_ver = '1.2.0'
  version @_ver + '-1'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/gparted/gparted/gparted-#{@_ver}/gparted-#{@_ver}.tar.gz"
  source_sha256 '6c90715d254d7a7ec0208b29007b64160dd9fb7df4c4aa7f8ec2c9d23114c719'

  depends_on 'parted'
  depends_on 'gtkmm3'
  depends_on 'intltool' => ':build'
  depends_on 'itstool' => ':build'
  depends_on 'yelp_tools' => ':build'
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
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --sbindir=#{CREW_PREFIX}/bin \
      --enable-online-resize \
      --enable-libparted-dmraid \
      --enable-xhost-root"
    system "make"
    system "cat <<'EOF'> gparted_
#!/bin/sh
xhost si:localuser:root
sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} gparted.elf
EOF"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/gparted", "#{CREW_DEST_PREFIX}/bin/gparted.elf"
    FileUtils.install 'gparted_', "#{CREW_DEST_PREFIX}/bin/gparted", mode: 0755
  end
end
