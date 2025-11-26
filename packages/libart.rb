require 'buildsystems/autotools'

class Libart < Autotools
  description 'Libart is a library for high-performance 2D graphics.'
  homepage 'https://www.levien.com/libart/'
  version '2.3.21'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/Archive/libart_lgpl.git'
  git_hashtag "LIBART_LGPL_#{version.tr('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'gnome_common' => :build
end
