require 'buildsystems/meson'

class Libxinerama < Meson
  description 'Xorg library, Xinerama is an X11 extension which provides support for extending a desktop across multiple displays.'
  homepage 'https://www.x.org/wiki/'
  compatibility 'aarch64 armv7l x86_64'
  license 'MIT'
  version '1.1.6'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxinerama.git'
  git_hashtag "libXinerama-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '480252174b8199236c1ccc71e051a546c1f567dbde2c80d722ec14e01025ea61',
     armv7l: '480252174b8199236c1ccc71e051a546c1f567dbde2c80d722ec14e01025ea61',
     x86_64: 'f8b61f71f6b0c957135c4a337302b9cbfa5e3fccc01f66365cd53238c6484a3a'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' => :build
  depends_on 'libxext' # R
end
