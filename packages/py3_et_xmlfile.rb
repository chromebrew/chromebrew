require 'buildsystems/python'

class Py3_et_xmlfile < Python
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://foss.heptapod.net/openpyxl/et_xmlfile'
  @_ver = '1.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/3d/5d/0413a31d184a20c763ad741cc7852a659bf15094c24840c5bdd1754765cd/et_xmlfile-1.1.0.tar.gz'
  source_sha256 '8eb9e2bc2f8c97e37a2dc85a09ecdcdec9d8a396530a6d5a33b30b9a92da0c5c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ba53d156e28c37affcce21cb2b8c07777b954999c77822d7cc2c1f0a80c254e',
     armv7l: '2ba53d156e28c37affcce21cb2b8c07777b954999c77822d7cc2c1f0a80c254e',
       i686: '989ce48c61be02e72b9940f094b6efbe6f2d086a6b6f136187818c1a37d61d40',
     x86_64: 'cf81d2eb5e7fef80e54cc3f36ddc84951c8e6f724bcaf457d5d8b63dc2f77c63'
  })

  depends_on 'python3' => :build
end
