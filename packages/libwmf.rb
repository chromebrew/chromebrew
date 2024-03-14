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
    aarch64: '59618537f064e8fe8138bb64549e373acb4daafc5a7810958c68af2debe8204d',
     armv7l: '59618537f064e8fe8138bb64549e373acb4daafc5a7810958c68af2debe8204d',
     x86_64: '001151fb0dab422ecfc300fefe3793d2b0e85b4c9d3cc43a7eb2841a325d221e'
  })

  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk2' => :build
  depends_on 'libbsd' # R
  depends_on 'libgd' => :build
  depends_on 'libjpeg' # R
  depends_on 'libmd' # R
  depends_on 'libpng' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'xwayland' => :build
  depends_on 'zlibpkg' # R

  gnome
end
