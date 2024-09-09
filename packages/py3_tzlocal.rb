require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version '5.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7c2ace6e301c1d9186e7662005b50984f7002600f17957aecf70a9a098fbaba',
     armv7l: 'f7c2ace6e301c1d9186e7662005b50984f7002600f17957aecf70a9a098fbaba',
       i686: '5804d8f570e8ffcabc113d3f6cdcc3067fe0a3ec6d5e4e30ab165c85ca0d032f',
     x86_64: '149362c1bf3797b6991ea4442252246409c9403f34bffd5727d5fccd90051f65'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
