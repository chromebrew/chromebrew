require 'buildsystems/autotools'

class Xcb_util_renderutil < Autotools
  description 'The xcb-util-renderutil package provides additional extensions to the XCB library'
  homepage 'https://xcb.freedesktop.org/'
  version '0.3.10'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcb-render-util.git'
  git_hashtag "xcb-util-renderutil-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1129f723592633bc655e902f5a8715294fbb16b68de40e9113735cf1f24dc618',
     armv7l: '1129f723592633bc655e902f5a8715294fbb16b68de40e9113735cf1f24dc618',
       i686: '4100d5c0a01b165790d6993cd6bcc1e73b9e3ff6e2e7f5c09b3ac9425cf2bc59',
     x86_64: '5d656eec964bedb059c208b15a069027d3921795c2e1cc2f219b7fd4e09536c4'
  })

  depends_on 'glibc' # R
  depends_on 'libxdmcp' # R

end
