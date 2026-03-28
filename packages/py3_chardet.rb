require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "7.4.0.post1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7672e5926ec3891d29d79bc20df675bafaafe7102544931d50c23dbeab0dcea2',
     armv7l: '7672e5926ec3891d29d79bc20df675bafaafe7102544931d50c23dbeab0dcea2',
       i686: '563a6a08ec4f3093721172b0fdbf742a5a088fa7e77a99cfeff4ca6f436faecb',
     x86_64: '1321e223532f84cf4da04a8b8b4db2d018ed4c4c21a1a810bd831ed1a75c558d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
