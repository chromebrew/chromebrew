require 'buildsystems/python'

class Avocado_framework < Python
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  version '112.0'
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a378adcadb53c3be8c7bf82cb61ca67157e82b63e7d34e809ad41a3189d14cf',
     armv7l: '6a378adcadb53c3be8c7bf82cb61ca67157e82b63e7d34e809ad41a3189d14cf',
       i686: 'b15ef7164ac47b3fbdcc821a116409ddaabd09410cfce7db38a11b50f12df054',
     x86_64: '3f299d803640057d49850454097ce822616da78ae6e8a0e6b36c5a729d7fbfd9'
  })

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'python3' => :build
end
