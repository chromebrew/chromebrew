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
    aarch64: 'c0277e43aa81434f869327be52541f88672ad33d468d2fcb1801cf76e7204468',
     armv7l: 'c0277e43aa81434f869327be52541f88672ad33d468d2fcb1801cf76e7204468',
       i686: 'd89423a977f7d80ac85d7ee25cd3f6ed85c5fb740560a9e748df68f0a02c5191',
     x86_64: '2a88f98ad97aa0ff5e237dde4b820ce58120c327633c5c56d4549d23afe965e8'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'xcb_util' => :build
end
