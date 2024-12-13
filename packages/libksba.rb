require 'buildsystems/autotools'

class Libksba < Autotools
  description 'Libksba is a library to make the tasks of working with X.509 certificates, CMS data and related objects more easy.'
  homepage 'https://www.gnupg.org/related_software/libksba/index.html'
  version '1.6.7'
  license 'LGPL-3+, GPL-2+ and GPL-3+'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libksba/libksba-#{version}.tar.bz2"
  source_sha256 'cf72510b8ebb4eb6693eef765749d83677a03c79291a311040a5bfd79baab763'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b93a69de2895d378b86d6b108eb31e9b4eef113310b94e43b5068ac1236c468a',
     armv7l: 'b93a69de2895d378b86d6b108eb31e9b4eef113310b94e43b5068ac1236c468a',
       i686: '7fa75bdb6503b2131dfe033b622ebfccba3559745e4ed4fffdc5bb68e8201980',
     x86_64: '4aa6690deccb3bd613022b245e37ca233af675789ce4af13d09e0f0cbf47ef9d'
  })

  depends_on 'npth' => :build
  depends_on 'glibc' # R
  depends_on 'libgpg_error' # R

  run_tests
end
