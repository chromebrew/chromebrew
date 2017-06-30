require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.15'
  source_url 'http://www.catb.org/~esr/ascii/ascii-3.15.tar.gz'
  source_sha256 'ace1db8b64371d53d9ad420d341f2b542324ae70437e37b4b75646f12475ff5f'

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp ascii #{CREW_DEST_DIR}/usr/local/bin"
  end
end

