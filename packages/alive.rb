require 'buildsystems/autotools'

class Alive < Autotools
  description 'Automatic login and keep-alive utility for Internet connections.'
  homepage 'https://www.gnu.org/software/alive/'
  version '2.0.5'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/alive/alive-2.0.5.tar.lz'
  source_sha256 '94cf3dbffd9644405ed4944f94a7bb989674321607318c5a35d5fabc56a75089'

  binary_url({
  })
  binary_sha256({
  })

  depends_on 'guile' # R
  depends_on 'inetutils' # L
end
