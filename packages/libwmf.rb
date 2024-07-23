require 'buildsystems/autotools'

class Libwmf < Autotools
  description 'libwmf is a library for reading vector images in Microsoft\'s native Windows Metafile Format (WMF)'
  homepage 'https://github.com/caolanm/libwmf'
  version '0.2.13'
  license 'LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/caolanm/libwmf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c51c1e8e723a5a8b8182a4880b2258976358c82002ff20b59e114368099a019a',
     armv7l: 'c51c1e8e723a5a8b8182a4880b2258976358c82002ff20b59e114368099a019a',
     x86_64: 'd394a1abc6bf1e1b2cb0484d39133500044c0a46523837093cda7733edb35bdd'
  })

  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libbsd' # R
  depends_on 'libgd' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libmd' # R
  depends_on 'libpng' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'xwayland' => :build
  depends_on 'zlibpkg' # R

  gnome

  pre_configure_options "CFLAGS=-I#{CREW_PREFIX}/include/freetype2/"
  configure_options "--with-x --with-freetype=#{CREW_PREFIX}/include/freetype2"
end
