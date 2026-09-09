require 'package'

class Typst < Package
  description 'A markup-based typesetting system that is powerful and easy to learn.'
  homepage 'https://typst.app/'
  version '0.15.1'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/typst/typst/releases/download/v#{version}/typst-armv7-unknown-linux-musleabi.tar.xz",
     armv7l: "https://github.com/typst/typst/releases/download/v#{version}/typst-armv7-unknown-linux-musleabi.tar.xz",
     x86_64: "https://github.com/typst/typst/releases/download/v#{version}/typst-x86_64-unknown-linux-musl.tar.xz"
  })
  source_sha256({
    aarch64: '44986312e557b9ac0f2c71d5d5156c0ad93b2da374d54c859d6c0c7c0b73709f',
     armv7l: '44986312e557b9ac0f2c71d5d5156c0ad93b2da374d54c859d6c0c7c0b73709f',
     x86_64: 'a6d077d0a95eed5a2eba715b2dae06be954f624ccbf85758a03f389ded33118c'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'typst', "#{CREW_DEST_PREFIX}/bin/typst", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'typst' to get started.\n"
  end
end
