require 'buildsystems/autotools'

class Libedit < Autotools
  description 'An autotooled and libtoolized port of the NetBSD Editline library (libedit).'
  homepage 'https://thrysoee.dk/editline/'
  version '20251016-3.1'
  compatibility 'all'
  license 'BSD-2'
  source_url "https://thrysoee.dk/editline/libedit-#{version}.tar.gz"
  source_sha256 '21362b00653bbfc1c71f71a7578da66b5b5203559d43134d2dd7719e313ce041'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1d1bff30aa008299109755393a5181bf1e8e5ee97cdc113e35b02b5e4646902',
     armv7l: 'd1d1bff30aa008299109755393a5181bf1e8e5ee97cdc113e35b02b5e4646902',
       i686: '3d6a09ba23138e49a60d28ac5bdcac03c7d4dbbb7f38f8a1b5efa3e1bcc74214',
     x86_64: '66475f8d1327be4a3492f3dc9e0e49a30a003e74cae6960e8699afc24863370e'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R

  autotools_configure_options "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw"
  run_tests
end
