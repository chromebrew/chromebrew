require 'package'

class Pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version '2.8.0'
  license 'BSD'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/pygments-2.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/pygments-2.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/pygments-2.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/pygments-2.8.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0b7af6a0717a3b929c8a51fb2466565239810090478b7a4ac23f0e3da2fbc04e',
     armv7l: '0b7af6a0717a3b929c8a51fb2466565239810090478b7a4ac23f0e3da2fbc04e',
       i686: 'ffe3bd980c153fb1592a6027b44cd4b57161211160e8d2ce4ee4b17d86528615',
     x86_64: '955f2f252e98842b63569334ad133908c2c527617b687f632bbfd1f4db8013b6'
  })

  def self.install
    system 'pip uninstall -y pygments'
    system "pip install --upgrade --no-warn-script-location pygments --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end

  def self.postinstall
    system 'pip install --upgrade pygments'
  end
end
