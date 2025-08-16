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
    aarch64: 'c89a2fd9eb7887299220acef5060415adeafa550d50e48775aa533dccc4255a4',
     armv7l: 'c89a2fd9eb7887299220acef5060415adeafa550d50e48775aa533dccc4255a4',
       i686: 'cb95ff5b0aa45583418ce973a79b9aca54360ccd3105b4c12a1c86b737a81975',
     x86_64: '0e24d1d1fd6744af535b07c1290b963720a8dfed8944ff0120bb558ab6cca58e'
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
