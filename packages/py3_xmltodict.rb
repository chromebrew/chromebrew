require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "0.15.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9edc13f5786d5ac50984c100faa9d51932532b102b9e9b1ba2dff1783c29a42',
     armv7l: 'd9edc13f5786d5ac50984c100faa9d51932532b102b9e9b1ba2dff1783c29a42',
       i686: 'ae16fb5d4104560a36e1692e3472d1fe150a8fd898d35ca9244c295ae525df40',
     x86_64: '42de1014c87d8fbadd9d18060a8ed23c33b1461223231a92418badb0e7d276b8'
  })

  depends_on 'python3' => :build

  no_source_build
end
