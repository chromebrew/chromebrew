require 'buildsystems/meson'

class Waypipe < Meson
  description 'A proxy for Wayland protocol applications. WARNING: different versions are incompatible'
  homepage 'https://gitlab.freedesktop.org/mstoeckl/waypipe'
  version '0.10.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mstoeckl/waypipe.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b96adfa989ddc31e40ed8c9d064d9f65e2bc76513ea06c139f58b5bbe1b885d',
     armv7l: '4b96adfa989ddc31e40ed8c9d064d9f65e2bc76513ea06c139f58b5bbe1b885d',
     x86_64: '1462f21b1a15e3f4860b7a2c231982106d2d90f2461c84eaae4db1182b78c918'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
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
