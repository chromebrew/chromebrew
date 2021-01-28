require 'package'

class Pyelftools < Package
  description 'Pure-Python library for parsing and analyzing ELF files and DWARF debugging information.'
  homepage 'https://github.com/eliben/pyelftools'
  version '0.27'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pyelftools-0.27-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pyelftools-0.27-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pyelftools-0.27-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pyelftools-0.27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6948872decb8cbd4b9da384e6684fcf55736bd1fd998b94878f0d7896a0c32bb',
      armv7l: '6948872decb8cbd4b9da384e6684fcf55736bd1fd998b94878f0d7896a0c32bb',
        i686: '2781fb4f954695bdb05a0e5c6b2c36a3b88bc89ae5c001fca16c9daa2c839363',
      x86_64: 'cd61b483e2268bfa2f09390710f44d183c8151b1e05d64dcb705ca297cda6b6d',
  })

  def self.install
    system "pip3 uninstall -y pyelftools"
    system "pip3 install --upgrade --no-warn-script-location pyelftools --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
