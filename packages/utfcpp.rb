require 'buildsystems/cmake'

class Utfcpp < CMake
  description 'UTF-8 with C++ in a Portable Way'
  homepage 'https://github.com/nemtrif/utfcpp'
  version '4.1.1'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/nemtrif/utfcpp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7bea3d29e491279f3dcb2072994af19a35e77e8658b69c276df86586b392f041',
     armv7l: '7bea3d29e491279f3dcb2072994af19a35e77e8658b69c276df86586b392f041',
       i686: '248c3e6823dd6ea37b1b9203528d63a5ae25be3bc3deb57ca7dd1f9f1b36ba2f',
     x86_64: '177c495d6576c437c4c910632b52021c39b8444772c5cdba921ded4533b1fef1'
  })
end
