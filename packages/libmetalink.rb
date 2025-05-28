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
    aarch64: '42cb115a3b2c323130bc34433ebfc14e63242a702fa0f28bda714564b22d0267',
     armv7l: '42cb115a3b2c323130bc34433ebfc14e63242a702fa0f28bda714564b22d0267',
       i686: 'c1b46a162c5ffbdc8f619161a71783510b481384376338d6dafcb32f7228baa4',
     x86_64: '4295610c625ae49b93d8d98e7614b4c9fd3c664ca305720f0e34b99bfabde420'
  })

  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'zlib' # R

  def self.patch
    downloader 'https://launchpadlibrarian.net/380798344/0001-fix-covscan-issues.patch',
               'd236dfa0d4a1938a40ff2ce4dd348c42b74ad68807df0f1b6ea69c11725fd9cf'
    system 'patch -Np1 -i 0001-fix-covscan-issues.patch'
  end

  autotools_configure_options '--with-libxml2 \
      --without-libexpat'
end
