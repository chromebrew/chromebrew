require 'buildsystems/cmake'

class Tint2 < CMake
  description 'A lightweight panel/taskbar for Linux and BSD'
  homepage 'https://gitlab.com/nick87720z/tint2'
  version '17.1.3'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/nick87720z/tint2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12133496955af7cbdfc9ed11711ef1399cdd9327deb93b8977a1f11348862a96',
     armv7l: '12133496955af7cbdfc9ed11711ef1399cdd9327deb93b8977a1f11348862a96',
     x86_64: '5fc3f22367383691d563b9b200cb05430ef04fb28286f513bafcc5f55f9d9d57'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'imlib2' => :executable
  depends_on 'librsvg' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcomposite' => :executable
  depends_on 'libxdamage' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxfixes' => :executable
  depends_on 'libxinerama' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'libxrender' => :executable
  depends_on 'pango' => :executable
  depends_on 'startup_notification' => :executable
  depends_on 'zlib' => :executable

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'

  def self.patch
    patch = [
      [
        # Add explicit dependency of tint2conf on libm.
        'https://gitlab.com/nick87720z/tint2/-/merge_requests/3.diff',
        '91793b0b09975f74769787c6cfde624130ed9a9cbf629bd13d63380f2daff799'
      ]
    ]
    ConvenienceFunctions.patch(patch)
  end
end
