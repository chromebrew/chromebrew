require 'buildsystems/meson'

class Waypipe < Meson
  description 'A proxy for Wayland protocol applications.'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.11.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a508d4c98ad12f81c73b4af692eac2ab251a154d4c969e92353355d08a574be8',
     armv7l: 'a508d4c98ad12f81c73b4af692eac2ab251a154d4c969e92353355d08a574be8',
     x86_64: 'aeee0548bb6a9164b37a19ef63621772c4785bc6bb5527f56ec6e5b28eb47047'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
