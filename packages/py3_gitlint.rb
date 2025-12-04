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
       i686: '4107fac020cfcf449ab791143a057fc622b1509b42624e78a2814060a54d535b',
     x86_64: '8c56260b4c3256cd566ffa090ea45c83e0b534bbc8b2da39d980baadcf063753'
  })

  depends_on 'python3' # R

  no_source_build
end
