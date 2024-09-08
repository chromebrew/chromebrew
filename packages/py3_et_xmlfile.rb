require 'buildsystems/pip'

class Py3_et_xmlfile < Pip
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://foss.heptapod.net/openpyxl/et_xmlfile'
  version '1.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ba53d156e28c37affcce21cb2b8c07777b954999c77822d7cc2c1f0a80c254e',
     armv7l: '2ba53d156e28c37affcce21cb2b8c07777b954999c77822d7cc2c1f0a80c254e',
       i686: '989ce48c61be02e72b9940f094b6efbe6f2d086a6b6f136187818c1a37d61d40',
     x86_64: 'cf81d2eb5e7fef80e54cc3f36ddc84951c8e6f724bcaf457d5d8b63dc2f77c63'
  })

  depends_on 'python3' => :build
end
