require 'buildsystems/pip'

class Py3_isodate < Pip
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  version "0.6.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc99ff5bbc98353bd77119ce4e994ec85975d41f8c87ed36e56f0eb2fa96132e',
     armv7l: 'bc99ff5bbc98353bd77119ce4e994ec85975d41f8c87ed36e56f0eb2fa96132e',
       i686: '0c1ee87c18a3c9e94b86998a031f126c73285b8b409324c7504cc875b2710fca',
     x86_64: 'c9fe9d5efc0b2a6ed0bae36d24d998a459172bed20af8ef6ce2dd47026af40e6'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
