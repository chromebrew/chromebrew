require 'buildsystems/autotools'

class Fakeroot < Autotools
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.37.2'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_#{version}.orig.tar.gz"
  source_sha256 '0eea60fbe89771b88fcf415c8f2f0a6ccfe9edebbcf3ba5dc0212718d98884db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29312d3f89552a9876c215b7c0dfb2d9b4e34639c5ce3a0d0bd6c687bf0f9868',
     armv7l: '29312d3f89552a9876c215b7c0dfb2d9b4e34639c5ce3a0d0bd6c687bf0f9868',
       i686: '5f31abf62547f183d5db5f5c138cf24ba8ab907dcf6145b2e0a6fd406d288e80',
     x86_64: 'fa89066a514460c8bf00e77b02f7bf1a07e7152be920ede97fce767916c86c65'
  })

  depends_on 'glibc' # R
  depends_on 'libcap'

  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074945
  autotools_pre_configure_options 'CFLAGS=-Wno-incompatible-pointer-types'
end
