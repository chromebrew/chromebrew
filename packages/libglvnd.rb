require 'buildsystems/meson'

class Libglvnd < Meson
  description 'The GL Vendor-Neutral Dispatch library'
  homepage 'https://gitlab.freedesktop.org/glvnd/libglvnd'
  version '1.7.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/glvnd/libglvnd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6329850b25600db1b87d71447b22bc26a9d378c1a6b164b1fcaf296be153bab7',
     armv7l: '6329850b25600db1b87d71447b22bc26a9d378c1a6b164b1fcaf296be153bab7',
     x86_64: '4a39596021a395d88bc512d0f2c8e72403aa8036fd2565bce47602551101c3c1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' => :build
  depends_on 'python3' => :build
  depends_on 'xorg_proto' => :build
end
