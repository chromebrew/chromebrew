require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version '3.10-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '933812e4fc1780ee39c2d24b7758320a27e3b8f0f1d35b6f73d3cf675f6ee8cc',
     armv7l: '933812e4fc1780ee39c2d24b7758320a27e3b8f0f1d35b6f73d3cf675f6ee8cc',
       i686: '7684da659cb9e024c554ca8747e536c31908f520b1470ebe68023e65b5ee4c88',
     x86_64: '2f92d90c413ca1a58524d1795ff5bfdaf9a43f690a961e388e6dccd31e1eaeb2'
  })

  depends_on 'python3' => :build

  no_source_build
end
