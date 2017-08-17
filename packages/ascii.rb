require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.16'
  source_url 'http://www.catb.org/~esr/ascii/ascii-3.16.tar.gz'
  source_sha256 'a94bb3970e8f1f63566f055517aecbdd46b11c4ccf142f77ffb80a79994f03a9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ascii-3.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '960f68dac5375dfe116f0b1a299761279b35890a1926b70607130eeebe052c45',
     armv7l: '960f68dac5375dfe116f0b1a299761279b35890a1926b70607130eeebe052c45',
       i686: 'e3df5f81fdfc3ff137a50372a50d79e44902c0569e12c253dcaddec824ec5259',
     x86_64: '4138b0c85c565d38cdcbea96edbd223551ff640d65868dc00e016cc72f64bc46',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp ascii #{CREW_DEST_DIR}/usr/local/bin"
  end
end

