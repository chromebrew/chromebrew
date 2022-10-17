require 'package'

class Libmetalink < Package
  description 'libmetalink is a Metalink library written in C language.'
  homepage 'https://launchpad.net/libmetalink/'
  version '0.1.3-3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://launchpad.net/libmetalink/trunk/libmetalink-0.1.3/+download/libmetalink-0.1.3.tar.xz'
  source_sha256 '86312620c5b64c694b91f9cc355eabbd358fa92195b3e99517504076bf9fe33a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmetalink/0.1.3-3_armv7l/libmetalink-0.1.3-3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmetalink/0.1.3-3_armv7l/libmetalink-0.1.3-3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmetalink/0.1.3-3_i686/libmetalink-0.1.3-3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmetalink/0.1.3-3_x86_64/libmetalink-0.1.3-3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0018a9cfa5c2a896b210b89f11112c8071ce470007c77c922085726ef82634ea',
     armv7l: '0018a9cfa5c2a896b210b89f11112c8071ce470007c77c922085726ef82634ea',
       i686: 'e2a61502581e8b39f621b0893bed87df8b2f108cb63b5396973d8b6c3f75aa60',
     x86_64: '62986bd07f7fd2ade3114e8600e1a920b8614447acdd34164b77181ceb3a6687'
  })

  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'zlibpkg' # R

  def self.patch
    downloader 'https://launchpadlibrarian.net/380798344/0001-fix-covscan-issues.patch',
               'd236dfa0d4a1938a40ff2ce4dd348c42b74ad68807df0f1b6ea69c11725fd9cf'
    system 'patch -Np1 -i 0001-fix-covscan-issues.patch'
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      #{CREW_ENV_OPTIONS} \
      --with-libxml2 \
      --without-libexpat"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
