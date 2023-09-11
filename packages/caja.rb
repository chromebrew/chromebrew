# Adapted from Arch Linux caja PKGBUILD at:
# https://github.com/archlinux/svntogit-community/blob/packages/caja/trunk/PKGBUILD

require 'buildsystems/autotools'

class Caja < Autotools
  description 'Caja file manager for the MATE desktop'
  homepage 'https://mate-desktop.org'
  version '1.27.2'
  license 'GPL-2+ LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://pub.mate-desktop.org/releases/#{version.rpartition('.')[0]}/caja-#{version}.tar.xz"
  source_sha256 '646ae6aa5174a765f2a4a6bc4ad4efd6b801f475f0aa7c2fd7e71bd84b5632bb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/caja/1.27.2_armv7l/caja-1.27.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/caja/1.27.2_armv7l/caja-1.27.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/caja/1.27.2_x86_64/caja-1.27.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '568e4400b459e79c878bfd9fd5031e13d813ff5667e2d60cec9654195da42c6a',
     armv7l: '568e4400b459e79c878bfd9fd5031e13d813ff5667e2d60cec9654195da42c6a',
     x86_64: 'b93b435a3d42a9ff39185912077549f9dec0132998506eae04f632c0ba096064'
  })

  depends_on 'at_spi2_core' # R                                                                                                                                                                                 depends_on 'cairo' # R                                                                                                                                                                                        depends_on 'dconf' # R                                                                                                                                                                                        depends_on 'exempi' # R                                                                                                                                                                                       depends_on 'expat' # R                                                                                                                                                                                        depends_on 'gcc_lib' # R                                                                                                                                                                                      depends_on 'gdk_pixbuf' # R                                                                                                                                                                                   depends_on 'glib' # R
  depends_on 'cairo' # R
  depends_on 'dconf' # R
  depends_on 'exempi' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'gvfs' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libbsd' # R
  depends_on 'libexif' # R
  depends_on 'libice' # R
  depends_on 'libmd' # R
  depends_on 'libnotify' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxml2' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'mate_desktop' # R
  depends_on 'pango' # R
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
