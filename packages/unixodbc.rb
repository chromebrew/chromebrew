require 'buildsystems/autotools'

class Unixodbc < Autotools
  description 'ODBC is an open specification for providing application developers with a predictable API with which to access Data Sources.'
  homepage 'https://www.unixodbc.org/'
  version '2.3.14'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://www.unixodbc.org/unixODBC-#{version}.tar.gz"
  source_sha256 '4e2814de3e01fc30b0b9f75e83bb5aba91ab0384ee951286504bb70205524771'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e2e6db704f11213d0ca3881077617bb5d92b3361f21ab06840d63f80e24b89f',
     armv7l: '6e2e6db704f11213d0ca3881077617bb5d92b3361f21ab06840d63f80e24b89f',
       i686: 'a488fb1187c3d3cb474f30ba278cbedf26a2b28faa05a1456a6b0847ddf9866a',
     x86_64: '59146420f716e3e9fda502642185b3662d57373c217cf3e7d625c38c02ee755b'
  })

  depends_on 'glibc' # R
  depends_on 'libtool' # R
  depends_on 'readline' # R
end
