require 'buildsystems/autotools'

class Gmime < Autotools
  description 'GMime is a powerful MIME (Multipurpose Internet Mail Extension) utility library. It is meant for creating, editing, and parsing MIME messages and structures.'
  homepage 'https://developer.gnome.org/gmime/'
  version '3.2.14'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/jstedfast/gmime.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aba50d887f3654b629d771b3a2a8545a88fd88b115b85b36c4c0ca851094628f',
     armv7l: 'aba50d887f3654b629d771b3a2a8545a88fd88b115b85b36c4c0ca851094628f',
     x86_64: '221c5d7bcb23ea1a985eb6cbf1834e1d3438f481ae3b1a33cc3a7069a8c06378'
  })

  depends_on 'glib' => :build
  depends_on 'gpgme' => :build
  depends_on 'vala' => :build

  gnome
end
