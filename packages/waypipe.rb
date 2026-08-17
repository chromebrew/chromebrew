require 'buildsystems/meson'

class Waypipe < Meson
  description 'A proxy for Wayland protocol applications.'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.11.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '078f95011784f27c5b546b97094c7fffea6a7e66d450fc59228cc58d5f2626bd',
     armv7l: '078f95011784f27c5b546b97094c7fffea6a7e66d450fc59228cc58d5f2626bd',
     x86_64: 'ad9b2b3a6f9e573d072aaed981c7f0494f41b9904268ef1efd19a0bd00cd585f'
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
