require 'buildsystems/meson'

class Xclock < Meson
  description 'The xclock package contains a simple clock application which is used in the default xinit configuration.'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xclock.1.html'
  version '1.2.1'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xclock.git'
  git_hashtag "xclock-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64ab00cadd65260ce137e4d7e4f5ce2b2b40e81327129269ad42e96996bceaab',
     armv7l: '64ab00cadd65260ce137e4d7e4f5ce2b2b40e81327129269ad42e96996bceaab',
     x86_64: '2e6b7c05ccd7efdc5970412f945e2c8b312689116add350e8ccb35dea9cceeaa'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxaw' => :executable
  depends_on 'libxft' => :executable
  depends_on 'libxkbfile' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'libxrender' => :executable
  depends_on 'libxt' => :executable
  depends_on 'wxwidgets' => :executable

  meson_options "-Dc_args='-I#{CREW_PREFIX}/include/wx-3.3'"
end
