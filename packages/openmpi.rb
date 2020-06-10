require 'package'

class Openmpi < Package
  description 'The Open MPI Project is an open source Message Passing Interface implementation that is developed and maintained by a consortium of academic, research, and industry partners.'
  homepage 'https://www.open-mpi.org/'
  version '4.0.1'
  compatibility 'all'
  source_url 'https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.1.tar.bz2'
  source_sha256 'cce7b6d20522849301727f81282201d609553103ac0b09162cf28d102efb9709'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openmpi-4.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openmpi-4.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openmpi-4.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openmpi-4.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ebfd586e6e8efcbdda5ec1c69356bf29adc2c15844405fc9fd6b595330cebff',
     armv7l: '6ebfd586e6e8efcbdda5ec1c69356bf29adc2c15844405fc9fd6b595330cebff',
       i686: '7b95e3be4d88619c4abdbe3df69534b023955699ec7633f310cb77bf320514d0',
     x86_64: '3985ef364b793db8053ae6a3640549a635bdda668134100e3017b17634e82eed',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
