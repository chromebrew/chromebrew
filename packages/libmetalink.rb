require 'buildsystems/autotools'

class Libmetalink < Autotools
  description 'libmetalink is a Metalink library written in C language.'
  homepage 'https://launchpad.net/libmetalink/'
  version "0.1.3-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://launchpad.net/libmetalink/trunk/libmetalink-0.1.3/+download/libmetalink-0.1.3.tar.xz'
  source_sha256 '86312620c5b64c694b91f9cc355eabbd358fa92195b3e99517504076bf9fe33a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae3f5041008e14ec38be0a14cb1797d0a5df289d7d1ebd482bddc1dabda2249e',
     armv7l: 'ae3f5041008e14ec38be0a14cb1797d0a5df289d7d1ebd482bddc1dabda2249e',
       i686: '63fc3bfa83e6b8f3c946f24c000c76c49d5e2401f51de274cc68dbe9b87d0030',
     x86_64: '51c357614dd3c43c8b3a7513106c82bb3436a85d1a4c2a22afdd7e204be51675'
  })

  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'libxml2' => :library
  depends_on 'zlib' # R

  def self.patch
    downloader 'https://launchpadlibrarian.net/380798344/0001-fix-covscan-issues.patch',
               'd236dfa0d4a1938a40ff2ce4dd348c42b74ad68807df0f1b6ea69c11725fd9cf'
    system 'patch -Np1 -i 0001-fix-covscan-issues.patch'
  end

  autotools_configure_options '--with-libxml2 \
      --without-libexpat'
end
