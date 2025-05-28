# Adapted from Arch Linux libdbusmenu PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libdbusmenu/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libdbusmenu_gtk3 < Autotools
  description 'Library for passing menus over DBus'
  homepage 'https://launchpad.net/libdbusmenu'
  @ubuntu_version = '18.10.20180917~bzr492+repack1-3.1ubuntu5'
  version '18.10.20180917-bcafbd2'
  license 'GPL3 LGPL2.1 LGPL3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.launchpad.net/ubuntu/+source/libdbusmenu'
  git_hashtag 'bcafbd2190848570fd57bb5f81d9f9bca119365f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '81541bf0bd0c873b702691e2c9ac27a89c02ab0518af08ece2e8d1016a921549',
     armv7l: '81541bf0bd0c873b702691e2c9ac27a89c02ab0518af08ece2e8d1016a921549',
     x86_64: 'bfb26200b3b33fa3f13bd01325f38d2b46d1b4631a8545de3c3f760883e175cd'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_common' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'intltool' => :build
  depends_on 'json_glib' # R
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'zlib' # R

  autotools_configure_options '--disable-dumper --disable-scrollkeeper --disable-gtk-doc --enable-introspection --with-gtk=3'

  def self.patch
    downloader "http://archive.ubuntu.com/ubuntu/pool/main/libd/libdbusmenu/libdbusmenu_#{@ubuntu_version}.debian.tar.xz", '2d00f79281340516f326468efee0e75651f0926834ce2671195f7a6b5945b314'
    FileUtils.mkdir 'ubuntu_patches'
    system "tar fx libdbusmenu_#{@ubuntu_version}.debian.tar.xz -C ubuntu_patches"
    Dir['ubuntu_patches/debian/patches/000*'].each do |patch|
      system "patch -Np1 -i #{patch}"
    end
  end
end
