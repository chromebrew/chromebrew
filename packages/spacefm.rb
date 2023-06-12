require 'package'

class Spacefm < Package
  description 'SpaceFM is a multi-panel tabbed file and desktop manager for Linux with built-in VFS, udev- or HAL-based device manager, customisable menu system, and bash-GTK integration.'
  homepage 'https://ignorantguru.github.io/spacefm/'
  version '1.0.6-1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/IgnorantGuru/spacefm/archive/1.0.6.tar.gz'
  source_sha256 'fedea9fcad776e0af4b8d90c5a1c86684a9c96ef1cdd4e959530ce93bdebe7c9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spacefm/1.0.6-1_armv7l/spacefm-1.0.6-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spacefm/1.0.6-1_armv7l/spacefm-1.0.6-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spacefm/1.0.6-1_x86_64/spacefm-1.0.6-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3fc55c994d114e0a46a0177829e023224a28c55f28baf33333a900e69063e7b9',
     armv7l: '3fc55c994d114e0a46a0177829e023224a28c55f28baf33333a900e69063e7b9',
     x86_64: '2da840c41c00055dd82414bc20fc24d8e6ab80b60267da1786d6e090a6392c1e'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'desktop_file_utilities' => :build
  depends_on 'eudev' # R
  depends_on 'ffmpegthumbnailer' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' # L
  depends_on 'libx11' # R
  depends_on 'pango' # R
  depends_on 'shared_mime_info' => :build
  depends_on 'zlibpkg' # R

  def self.patch
    # GCC 10.1+ Fixes
    downloader 'https://github.com/IgnorantGuru/spacefm/pull/772.patch',
               '737cc5f72911bcd00160260a4cd481d6fbc498f443870cbb1a7df779568e985b'
    system 'patch -Np1 -i 772.patch', exception: false
    # Configure.ac: Use POSIX compatible substitutions that are not specific to bash.
    downloader 'https://github.com/IgnorantGuru/spacefm/pull/813.patch',
               '87866ba5ff33233971ba0a31a5faddd09e31c46f4d694f4150af2e5ccefe0cf5'
    system 'patch -Np1 -i 813.patch'
    # add missing include to sys/sysmacros.h for 'major' and 'minor'
    downloader 'https://github.com/IgnorantGuru/spacefm/pull/781.patch',
               '1b00ecbb371488f966030eb6f711957480f9c5462cdf2721103574c58958dffd'
    system 'patch -Np1 -i 781.patch'
    # fix activating items with no focused item
    downloader 'https://github.com/IgnorantGuru/spacefm/pull/749.patch',
               'e263ab364fb812016d0364c3d66ddddef4f70c069facbeec208b39ea159b75df'
    system 'patch -Np1 -i 749.patch'
    # Avoid X-specific calls under Wayland
    downloader 'https://github.com/IgnorantGuru/spacefm/pull/801.patch',
               '1cd00a6ac01792e381c5fbf8d9f2eb78ac908a59760d947a070a5efe73ccabe7'
    system 'patch -Np1 -i 801.patch'
  end

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS} \
      --with-gtk3 \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
