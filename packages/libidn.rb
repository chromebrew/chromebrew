require 'buildsystems/autotools'

class Libidn < Autotools
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  @_ver = '1.41'
  version "#{@_ver}-1"
  license 'GPL-2+ and LGPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://git.savannah.gnu.org/git/libidn.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e288c83e54adc2398f7f609cbc229b22d81b6d690ec90b0cf598dfb337b7f6e',
     armv7l: '2e288c83e54adc2398f7f609cbc229b22d81b6d690ec90b0cf598dfb337b7f6e',
     x86_64: 'c5b6852ce260dc34f99dd66d2145e45f5d3c9ed4f24fdfc52173dd938fc4ce56'
  })

  depends_on 'fig2dev' => :build
  depends_on 'gengetopt' => :build
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libunistring' # R
  depends_on 'wget2' => :build
end
