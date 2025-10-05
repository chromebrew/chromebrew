require 'buildsystems/meson'

class Libxinerama < Meson
  description 'Xorg library, Xinerama is an X11 extension which provides support for extending a desktop across multiple displays.'
  homepage 'https://www.x.org/wiki/'
  compatibility 'aarch64 armv7l x86_64'
  license 'MIT'
  version '1.1.5-cc22c2f'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxinerama.git'
  git_hashtag 'cc22c2f60c3862482562955116d5455263b443dc'
  # git_hashtag "libXinerama-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '81226a97841812aa627e05e987a06156d84ba790813c13edefe4bbcb9d615e2a',
     armv7l: '81226a97841812aa627e05e987a06156d84ba790813c13edefe4bbcb9d615e2a',
     x86_64: 'f8b61f71f6b0c957135c4a337302b9cbfa5e3fccc01f66365cd53238c6484a3a'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' => :build
  depends_on 'libxext' # R
end
