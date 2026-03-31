require 'buildsystems/meson'

class Waypipe < Meson
  description 'A proxy for Wayland protocol applications.'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.11.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7ece71b5296e30daccc50d223d6df20e0d56b02e6c109b8c8f3b8ea8996b2f3',
     armv7l: 'b7ece71b5296e30daccc50d223d6df20e0d56b02e6c109b8c8f3b8ea8996b2f3',
     x86_64: '87d5054eb166205c5e55fbb736ca2dd3b16abd38d432a775be6a45ec0088f0dc'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'libdrm' => :build
  depends_on 'rust' => :build
  depends_on 'scdoc' => :build
  depends_on 'shaderc' => :build
  depends_on 'speexdsp' => :build

  def self.prebuild
    system 'cargo fetch --locked'
  end

  meson_options '-Dwith_systemtap=false'
end
