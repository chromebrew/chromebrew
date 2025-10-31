require 'buildsystems/pip'

class Py3_requests < Pip
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  version "2.32.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47c21757f2acf9b67ddbec11d99e69f5ca6045c00e674f48d7500143958ef849',
     armv7l: '47c21757f2acf9b67ddbec11d99e69f5ca6045c00e674f48d7500143958ef849',
       i686: '06230e6e7d261bd448a61426c27facc8187344fa4970a00a12fd44fff284e83b',
     x86_64: '393b178ab3afb95acc914fb1ffcaba60db65086ae8561c0e448acb761d8d689e'
  })

  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :build

  no_source_build
end
