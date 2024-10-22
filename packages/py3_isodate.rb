require 'buildsystems/pip'

class Py3_isodate < Pip
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  version "0.7.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47920fb0bd9a9aae0f1678d059b9d483935f721a47f70b100e4c85541d998d5b',
     armv7l: '47920fb0bd9a9aae0f1678d059b9d483935f721a47f70b100e4c85541d998d5b',
       i686: 'bbb25d28dd44537429185cdc8363028fa5ccd5582c2a559a6647b1f60a963056',
     x86_64: '608bba37d1de48912428523ea474fbcd263bf27e4d894582a587c168ee895598'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
