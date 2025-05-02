require 'buildsystems/pip'

class Ranger_fm < Pip
  description 'A VIM-inspired filemanager for the console.'
  homepage 'https://ranger.github.io/'
  version '1.9.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdfafcf80bfef8e3919e7d3956965c663650a9653319d7b838061fc68125d73a',
     armv7l: 'cdfafcf80bfef8e3919e7d3956965c663650a9653319d7b838061fc68125d73a',
       i686: '3029bcfb1fb99d795892372ddac7e1c9369f5319f3374e3f854c888b477cde02',
     x86_64: '3953d31916d281aa1a6309189b2776d6b47ccbf86c8f3cff73a7e344ef74f44c'
  })

  depends_on 'less'
  depends_on 'ncurses'
  depends_on 'python3'

  no_source_build
end
