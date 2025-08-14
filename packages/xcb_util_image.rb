require 'buildsystems/autotools'

class Xcb_util_image < Autotools
  description 'The xcb-util-image package provides additional extensions to the XCB library.'
  homepage 'https://xcb.freedesktop.org/'
  version '0.4.1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcb-image.git'
  git_hashtag "xcb-util-image-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b98d3f85937bfe7f272b7ab39406ee4a645c583a0792fded18e74a82603769e',
     armv7l: '5b98d3f85937bfe7f272b7ab39406ee4a645c583a0792fded18e74a82603769e',
       i686: '8f539e6fa5753bc8bef0d873fd0a12a66e8a17fd5b61bf94b75b0268e567fe1e',
     x86_64: 'f6934d3b2cf842afb62fa1b421a29260a8fbb2be5567977661552c4a3d43d941'
  })

  depends_on 'xcb_util'
end
