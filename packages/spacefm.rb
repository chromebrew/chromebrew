require 'package'

class Spacefm < Package
  description 'SpaceFM is a multi-panel tabbed file and desktop manager for Linux with built-in VFS, udev- or HAL-based device manager, customisable menu system, and bash-GTK integration.'
  homepage 'https://ignorantguru.github.io/spacefm/'
  version '1.0.6-1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/IgnorantGuru/spacefm/archive/1.0.6.tar.gz'
  source_sha256 'fedea9fcad776e0af4b8d90c5a1c86684a9c96ef1cdd4e959530ce93bdebe7c9'
  binary_compression 'tar.zst'

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
  depends_on 'zlib' # R

  def self.patch
    # GCC 10.1+ Fixes
    patches = [
      ['https://patch-diff.githubusercontent.com/raw/IgnorantGuru/spacefm/pull/772.patch',
       '0e609c39362cbd9a0768e5555e3e047efeb37bab5e9371ae86295501e1a11f3d'],
      # Configure.ac: Use POSIX compatible substitutions that are not specific to bash.
      ['https://patch-diff.githubusercontent.com/raw/IgnorantGuru/spacefm/pull/813.patch',
       '87866ba5ff33233971ba0a31a5faddd09e31c46f4d694f4150af2e5ccefe0cf5'],
      # Add missing include to sys/sysmacros.h for 'major' and 'minor'.
      ['https://patch-diff.githubusercontent.com/raw/IgnorantGuru/spacefm/pull/781.patch',
       '1b00ecbb371488f966030eb6f711957480f9c5462cdf2721103574c58958dffd'],
      # Fix activating items with no focused item.
      ['https://patch-diff.githubusercontent.com/raw/IgnorantGuru/spacefm/pull/749.patch',
       'e263ab364fb812016d0364c3d66ddddef4f70c069facbeec208b39ea159b75df'],
      # Avoid X-specific calls under Wayland.
      ['https://patch-diff.githubusercontent.com/raw/IgnorantGuru/spacefm/pull/801.patch',
       '1cd00a6ac01792e381c5fbf8d9f2eb78ac908a59760d947a070a5efe73ccabe7']
    ]
    ConvenienceFunctions.patch(patches)
  end

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
      --with-gtk3 \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
