require 'package'

class Heroku < Package
  description 'The Heroku Command Line Interface (CLI), formerly known as the Heroku Toolbelt, is a tool for creating and managing Heroku apps from the command line / shell of various operating systems.'
  homepage 'https://devcenter.heroku.com/articles/heroku-cli'
  version '6.13.9'
  source_url 'https://github.com/heroku/cli/archive/v6.13.9.tar.gz'
  source_sha256 '76699029d86fc10326f8cf39b0c0a3b1f322dee39bd7c96fa81e34e52ff454f9'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/heroku-6.13.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/heroku-6.13.9-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/heroku-6.13.9-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/heroku-6.13.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '73f9f8288e4c8767dd3d6158ab86b1384c734367b639c18d4fce971c133cb31d',
     armv7l: '73f9f8288e4c8767dd3d6158ab86b1384c734367b639c18d4fce971c133cb31d',
       i686: '787f77bde4831a1e82ec9777dfe5a16c4837f07a04f74fd5f51637288c469f1d',
     x86_64: '7b78ab9be7f1c12c2d2b3d11957e749729089a2bc1b8342f4fc1253ecfe229e6',
  })

  depends_on 'yarn'

  def self.build
    system 'yarn install'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/heroku"
    system "cp -r . #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/heroku"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "ln -s #{CREW_LIB_PREFIX}/heroku/bin/run #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/heroku"
  end
end
