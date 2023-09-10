require 'buildsystems/autotools'

class Libidn < Autotools
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  version '1.41'
  license 'GPL-2+ and LGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://git.savannah.gnu.org/git/libidn.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn/1.41_armv7l/libidn-1.41-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn/1.41_armv7l/libidn-1.41-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn/1.41_x86_64/libidn-1.41-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a13930c50b038b5cb2c0b36cd0853779a44fc8491cd37cc269e41c1d30b76b66',
     armv7l: 'a13930c50b038b5cb2c0b36cd0853779a44fc8491cd37cc269e41c1d30b76b66',
     x86_64: '63c4bf2c4d9f05771f0d980009977188835daa66e6445d447bc641733dae4cdc'
  })

  depends_on 'gengetopt' => :build
  depends_on 'fig2dev' => :build
  depends_on 'wget' => :build
  depends_on 'gperf'

  depends_on 'glibc' # R
  depends_on 'libunistring'
end
