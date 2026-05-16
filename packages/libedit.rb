require 'buildsystems/autotools'

class Libedit < Autotools
  description 'An autotooled and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'https://thrysoee.dk/editline/'
  version '20260512-3.1'
  compatibility 'all'
  license 'BSD-2'
  source_url "https://thrysoee.dk/editline/libedit-#{version}.tar.gz"
  source_sha256 '432d5e7ea8b0116dd39f2eca7bc11d0eed77faa6b77ea526ace89907c23ea4a0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46e8ef37ccba9429253ecad8f6cf6c6103c54714448ece580a9b6b66724cc626',
     armv7l: '46e8ef37ccba9429253ecad8f6cf6c6103c54714448ece580a9b6b66724cc626',
       i686: '5c361a625d545db25be17736ea2de9adb5daa8283b890848621909fc06e0540b',
     x86_64: 'a224782e90402560c72e5df9873c10c6e0eeca0d1791139154827c0580166b28'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ncurses' => :library

  autotools_configure_options "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw"
  run_tests
end
