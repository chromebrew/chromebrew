require 'buildsystems/autotools'

class Stunnel < Autotools
  description "Stunnel is a proxy designed to add TLS encryption functionality to existing clients and servers without any changes in the programs' code."
  homepage 'https://www.stunnel.org/index.html'
  version '5.72'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://www.stunnel.org/downloads/stunnel-5.72.tar.gz'
  source_sha256 '3d532941281ae353319735144e4adb9ae489a10b7e309c58a48157f08f42e949'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff4a682e17d159061c9d27ba1fb059fa157dcadac3e17a9cd1497ed026f9be8f',
     armv7l: 'ff4a682e17d159061c9d27ba1fb059fa157dcadac3e17a9cd1497ed026f9be8f',
       i686: '85f066d8558b53f840191a7c22066a39ad56b25ae9c1082d4cb11a4c39403133',
     x86_64: 'be01355c6615b27aa4e3bbe96ef820fe2e5a208b361d4d997a1ff4553848a77b'
  })

  depends_on 'openssl'
end
