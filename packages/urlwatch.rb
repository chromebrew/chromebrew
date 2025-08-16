require 'buildsystems/python'

class Urlwatch < Python
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  version '2.29'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/thp/urlwatch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7985edafb0dab1e7812bb0401ebd81b90a6637f05c9883599539338586e04013',
     armv7l: '7985edafb0dab1e7812bb0401ebd81b90a6637f05c9883599539338586e04013',
       i686: '2264b9daf6f9f9bfb9a49f0a4152ef5900b372a7cb370e58bfe8944ff1991c82',
     x86_64: 'd2e6b320119f750e6535355f40d096a806c304a15984fbb024a47fb6e9259c17'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_cssselect'
  depends_on 'py3_minidb'
  depends_on 'py3_platformdirs'
  depends_on 'py3_pyyaml'
  depends_on 'py3_requests'
  depends_on 'py3_keyring'
  depends_on 'python3' => :build
end
