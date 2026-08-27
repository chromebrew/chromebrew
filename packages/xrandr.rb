require 'buildsystems/autotools'

class Xrandr < Autotools
  description 'Command line interface to X11 Resize, Rotate, and Reflect (RandR) extension'
  homepage 'https://gitlab.freedesktop.org/xorg/app/xrandr'
  version '1.5.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xrandr.git'
  git_hashtag "xrandr-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd04bea69eb13ed9e46d59c34e879eec0c4d1ce433affda981d4aebc319d3ef9e',
     armv7l: 'd04bea69eb13ed9e46d59c34e879eec0c4d1ce433affda981d4aebc319d3ef9e',
     x86_64: '8547c100ec66efd87de966dc0107a5ecc1469969ff9c7762bca3c988b4eb97d4'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'libxrender' => :executable

  run_tests
end
