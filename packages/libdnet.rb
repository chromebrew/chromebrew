require 'package'

class Libdnet < Package
  description 'libdnet provides a simplified, portable interface to several low-level networking routines.'
  homepage 'https://github.com/ofalk/libdnet'
  version '1.16.3'
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://github.com/ofalk/libdnet/archive/libdnet-1.16.3.tar.gz'
  source_sha256 '83171a9f6e96d7a5047d6537fce4c376bdf6d867f8d49cf6ba434a0f3f7b45c1'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdnet/1.16.3_armv7l/libdnet-1.16.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdnet/1.16.3_armv7l/libdnet-1.16.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdnet/1.16.3_i686/libdnet-1.16.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdnet/1.16.3_x86_64/libdnet-1.16.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '29464e04c86cca3a2e2a4759a01643eeb0cb914d323e10041d89ea33b420cbcb',
     armv7l: '29464e04c86cca3a2e2a4759a01643eeb0cb914d323e10041d89ea33b420cbcb',
       i686: '5000d68a79037ab04b9e3a5c0a23e473f34917ee7de38476c0ad099ef825a8d8',
     x86_64: 'db79eb40216c5bfafdef327f9a368c37c9cd524e043203477ab2cc9558610ca1'
  })

  depends_on 'check' => :build

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
