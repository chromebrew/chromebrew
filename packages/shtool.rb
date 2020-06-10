require 'package'

class Shtool < Package
  description 'GNU shtool is a compilation of small but very stable and portable shell scripts into a single shell tool.'
  homepage 'http://savannah.gnu.org/projects/shtool'
  version '2.0.8'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/shtool/shtool-2.0.8.tar.gz'
  source_sha256 '1298a549416d12af239e9f4e787e6e6509210afb49d5cf28eb6ec4015046ae19'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/shtool-2.0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/shtool-2.0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/shtool-2.0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/shtool-2.0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aa29d402a98610a0191860e03429d0247a49d1e3158349a49f9daea57ba35f99',
     armv7l: 'aa29d402a98610a0191860e03429d0247a49d1e3158349a49f9daea57ba35f99',
       i686: 'b28b62a0e0343d20c0b56e968eb622ca3e05aa21839034cbee45f25966d372a4',
     x86_64: '1ba8270fd8bfc04dbaa68cfec0f257c94e7bcd3b8e1a62637e80681dde3cb85f',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp shtool #{CREW_DEST_PREFIX}/bin"
    system "cp *.1 #{CREW_DEST_PREFIX}/man/man1"
  end
end
