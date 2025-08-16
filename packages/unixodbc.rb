require 'buildsystems/autotools'

class Unixodbc < Autotools
  description 'ODBC is an open specification for providing application developers with a predictable API with which to access Data Sources.'
  homepage 'https://www.unixodbc.org/'
  version '2.3.12'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://www.unixodbc.org/unixODBC-#{version}.tar.gz"
  source_sha256 '52833eac3d681c8b0c9a5a65f2ebd745b3a964f208fc748f977e44015a31b207'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a96a7d082d04ad0df1f5a509d30f75072696773662345afddd57d2e8d5d46cff',
     armv7l: 'a96a7d082d04ad0df1f5a509d30f75072696773662345afddd57d2e8d5d46cff',
       i686: 'fb62c1ad09e31efc8653afcbea8219630c62c953321749821af0f9b670998564',
     x86_64: '3a54dac313893c8a2aa8ec263a1b28884ec184f72e54e941fe68d923d618d124'
  })

  depends_on 'glibc' # R
end
