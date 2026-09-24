require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.9.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5cd57a8ff89f32327beb76eefb26e0f54ffdd40011cf5efa43d1020c8de7105',
     armv7l: 'd5cd57a8ff89f32327beb76eefb26e0f54ffdd40011cf5efa43d1020c8de7105',
       i686: 'e9284f353e30a25bb93ca22a3ac86ea303e4e6c92ac28e55dc3bc9acf8ac5e9e',
     x86_64: 'a8966b19e9326401c9a34b3dd8d1a3809317bbf97dc814c4b21270a1fd5c112d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
