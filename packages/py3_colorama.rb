require 'buildsystems/pip'

class Py3_colorama < Pip
  description 'Colorama makes ANSI color sequences work on MS Windows.'
  homepage 'https://github.com/tartley/colorama/'
  version "0.4.6-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'abb3c24bb0debe78930de08d4af4f5e4ca376424abdfa1cb8dcda53c08832355',
     armv7l: 'abb3c24bb0debe78930de08d4af4f5e4ca376424abdfa1cb8dcda53c08832355',
       i686: '9da74cf5afbdffc5f0238a3fb3e2ad08b8fc6badf64bdf937f41e8de718fcb25',
     x86_64: '532a76e661010af7b55b1e30b2979ebdb7d89863aec40d32dfc6cc78893041af'
  })

  depends_on 'python3' => :logical

  no_source_build
end
