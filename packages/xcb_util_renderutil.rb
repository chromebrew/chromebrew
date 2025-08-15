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
    aarch64: '8bef0641c124c63ab43a5258fff69061d5c29215dba6435f6bd198a0f962f9a6',
     armv7l: '8bef0641c124c63ab43a5258fff69061d5c29215dba6435f6bd198a0f962f9a6',
       i686: 'd58020baa86070d0ba6cf6299d2b19cfd7660182781a7dcf703a2b905dd86031',
     x86_64: '5d656eec964bedb059c208b15a069027d3921795c2e1cc2f219b7fd4e09536c4'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxau' # R
end
