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
    aarch64: 'a7ef0904fae0ccd7aa2ef6978e0030dbf33a5989adc56425e4c59e204be287d1',
     armv7l: 'a7ef0904fae0ccd7aa2ef6978e0030dbf33a5989adc56425e4c59e204be287d1',
       i686: '7abf912d9dec883ab4a3fa518dfe0fadc0c361cbb54c05bf6cc8e3e3cf747b91',
     x86_64: 'f8a09e641fedde3bac45796ad978d477cb54adfadbe6963ebe6943810b5647d6'
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
