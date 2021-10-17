require 'buildsystems/autotools/v1'

class M4 < Autotools_v1
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  @_ver = '1.4.19'
  version @_ver + '-1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/m4/m4-#{@_ver}.tar.xz"
  source_sha256 '63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96'

  depends_on 'libsigsegv'

  configure_options "--with-libsigsegv \
                    --with-packager='Chromebrew' \
                    --with-packager-version='#{CREW_VERSION}' \
                    --with-packager-bug-reports='https://github.com/skycocker/chromebrew/issues'"
  check? true
end
