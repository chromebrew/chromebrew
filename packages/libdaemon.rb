require 'package'

class Libdaemon < Package
  description 'libdaemon is a lightweight C library that eases the writing of UNIX daemons.'
  homepage 'http://0pointer.de/lennart/projects/libdaemon/'
  version '0.14'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'http://0pointer.de/lennart/projects/libdaemon/libdaemon-0.14.tar.gz'
  source_sha256 'fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '352b9f73b8619625b9eaaf7725cd189c637987b4223f63e7a04cea9e61ec78b6',
     armv7l: '352b9f73b8619625b9eaaf7725cd189c637987b4223f63e7a04cea9e61ec78b6',
       i686: 'f0c4b57f8d6f3aba46920cc44efc57da08df353301cb12e100d7005968592299',
     x86_64: 'a44869e8caed88eb021476bf3a9682394ac31c31bf7f74395a0995a3e74299dd'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
