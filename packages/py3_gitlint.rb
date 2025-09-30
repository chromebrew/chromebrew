require 'buildsystems/pip'

class Py3_gitlint < Pip
  description 'Git commit message linter written in python, checks your commit messages for style.'
  homepage 'https://jorisroovers.github.io/gitlint'
  version "0.19.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e16bc1d36b00183fd0ed89106caf29de7b08c2aea199764ba377bfdde1d57ca9',
     armv7l: 'e16bc1d36b00183fd0ed89106caf29de7b08c2aea199764ba377bfdde1d57ca9',
       i686: '30432ece142024deb777e96ca4789ca17fb0d43aa18f2271a8ca822fbad816dd',
     x86_64: '9b2c9211bc90a5368fbc5a6a224144f29e8c3078b54a6cb2eb57798d94acc4a5'
  })

  depends_on 'python3' # R

  no_source_build
end
