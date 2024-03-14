require 'buildsystems/autotools'

class Gmime < Autotools
  description 'GMime is a powerful MIME (Multipurpose Internet Mail Extension) utility library. It is meant for creating, editing, and parsing MIME messages and structures.'
  homepage 'https://developer.gnome.org/gmime/'
  version '3.2.3'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/jstedfast/gmime/archive/3.2.3.tar.gz'
  source_sha256 '5190dd45e297e2bdeca4b14b7055d37ec07b0fa1fe936159bdb69ddb7c91dd53'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'aba50d887f3654b629d771b3a2a8545a88fd88b115b85b36c4c0ca851094628f',
     armv7l: 'aba50d887f3654b629d771b3a2a8545a88fd88b115b85b36c4c0ca851094628f',
     x86_64: '221c5d7bcb23ea1a985eb6cbf1834e1d3438f481ae3b1a33cc3a7069a8c06378'
  })

  depends_on 'glib'
  depends_on 'gpgme'
  depends_on 'vala'

  gnome
end
