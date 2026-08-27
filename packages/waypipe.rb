require 'buildsystems/meson'

class Waypipe < Meson
  description 'A proxy for Wayland protocol applications.'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.11.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7d11d37f0a09232d2dd77e8bb6a23fc2ff5a147e89aae1cce3c515227ef3b54',
     armv7l: 'e7d11d37f0a09232d2dd77e8bb6a23fc2ff5a147e89aae1cce3c515227ef3b54',
     x86_64: '5030328ae4e2754d99754dfd759cd09dde0092d1ea797dfdfe4a49e7c853c287'
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
