require 'buildsystems/meson'

class Rendercheck < Meson
  description 'rendercheck is a program to test a Render extension implementation against separate calculations of expected output.'
  homepage 'https://www.x.org/wiki/'
  version '1.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/test/rendercheck.git'
  git_hashtag "rendercheck-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90b0f792889946717870f1497e523c3229cb5840feaf1152da6a125710310697',
     armv7l: '90b0f792889946717870f1497e523c3229cb5840feaf1152da6a125710310697',
       i686: 'b0ca933742e0d17470c8f1d3e66dac65c5a03ac4d490a477e6e59c700b08b1b7',
     x86_64: '7c29b512ecdf2472ade1bce7f7b7491cd8f828a1146061fa8e2e512de6dd1dc9'
  })
end
