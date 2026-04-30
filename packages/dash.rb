require 'buildsystems/autotools'

class Dash < Autotools
  description 'The Debian Almquist Shell (dash) is a POSIX-compliant shell derived from ash that executes scripts faster than bash and has fewer library dependencies.'
  homepage 'https://salsa.debian.org/debian/dash/'
  version '0.5.12-f47009f'
  license 'BSD'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/dash.git'
  git_hashtag 'upstream/0.5.12+git20240518+f47009f9a76e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c11486d7feb0581f5828bfd258433d0adfb08ee45c8dc7cbe4752586df18f4a8',
     armv7l: 'c11486d7feb0581f5828bfd258433d0adfb08ee45c8dc7cbe4752586df18f4a8',
       i686: 'fde5c4a4a255e7270ba026a795f93aecc4076b1327de3951598800b5a96e91d0',
     x86_64: '57a73df2cff50a4cc86245ce85e9c2fdf5f372884af3ccda7341c0d940f3b5a8'
  })

  depends_on 'glibc' => :executable
  depends_on 'libedit' => :executable

  autotools_configure_options '--with-libedit'

  run_tests
end
