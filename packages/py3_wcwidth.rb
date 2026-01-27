require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9065c226814fc0c991a91c19615a2497fe6e7e9c3300159947af5b6f3a600b22',
     armv7l: '9065c226814fc0c991a91c19615a2497fe6e7e9c3300159947af5b6f3a600b22',
       i686: '7553292bbc0096b8a0bd82a06f8f1dab7d0f028431853727438cdd683f845cb4',
     x86_64: '31463ea8a617ed448942a81c86d4ebd7c93acf1f2f65a81ddd51dca52b11db95'
  })

  depends_on 'python3' => :build

  no_source_build
end
