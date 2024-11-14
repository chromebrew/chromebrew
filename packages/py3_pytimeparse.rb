require 'buildsystems/pip'

class Py3_pytimeparse < Pip
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  version "1.1.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '456fe5518f3837b8e4f39c7fd287847626548ff809d555f41014ecea93f50c6b',
     armv7l: '456fe5518f3837b8e4f39c7fd287847626548ff809d555f41014ecea93f50c6b',
       i686: '755cab8cb4689906f9ba07519609e5b883ad4c8f84f4d058ac24689672f54a06',
     x86_64: 'ce17f5826c782eac297afdd17a2b005792012840c42d973a63108672146ab079'
  })

  depends_on 'python3' => :build

  no_source_build
end
