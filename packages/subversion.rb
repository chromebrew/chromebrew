require 'buildsystems/autotools'

class Subversion < Autotools
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.14.4'
  license 'Apache-2.0, BSD, MIT, BSD-2, FSFAP and unicode'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://dlcdn.apache.org/subversion/subversion-#{version}.tar.bz2"
  source_sha256 '44ead116e72e480f10f123c914bb6f9f8c041711c041ed7abff1b8634a199e3c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62704e12605742de34089c350055f2859e6dd23731921c1db9eb7b60381316d3',
     armv7l: '62704e12605742de34089c350055f2859e6dd23731921c1db9eb7b60381316d3',
     x86_64: 'c05a9400f3fdecc25f2c1eba9a5502926eb234a5aa6302e5e2392be27fd97d6d'
  })

  depends_on 'apr_util'
  depends_on 'expat'
  depends_on 'serf'
  depends_on 'sqlite'

  configure_options '--disable-static --with-utf8proc=internal'

  def self.prebuild
    ConvenienceFunctions.libtoolize('expat')
  end
end
