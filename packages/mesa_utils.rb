require 'package'

class Mesa_utils < Package
  description 'Open-source implementation of the OpenGL specification - Provides tools such as glxinfo, glxgears'
  homepage 'https://www.mesa3d.org'
  version '8.5.0'
  license 'mesa'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/demos.git'
  git_hashtag "mesa-demos-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b3f8f18610f75ed076605c2a05e9748710939b29bbe8279b5957bddeacdec9b',
     armv7l: '0b3f8f18610f75ed076605c2a05e9748710939b29bbe8279b5957bddeacdec9b',
       i686: '5ac984ba6126371d59dbf96828fe87ef084ca4f3427067d2920440a36615ed5b',
     x86_64: 'e6f20f9a1f631d085934c3fce0d90c1945f88e72c3ee436a0b8460cf7d3d8150'
  })

  depends_on 'mesa'
  depends_on 'glew'
  depends_on 'freeglut'
  depends_on 'wayland_protocols' => :build
  depends_on 'glibc' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'wayland' # R

  def self.build
    system 'meson setup build'
    system "meson configure #{CREW_MESON_OPTIONS} \
              build"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
