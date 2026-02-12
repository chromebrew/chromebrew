require 'package'

class Micro < Package
  description 'A modern and intuitive terminal-based text editor'
  homepage 'https://micro-editor.github.io/'
  version '2.0.15'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/zyedidia/micro/releases/download/v#{version}/micro-#{version}-linux-arm.tar.gz",
     armv7l: "https://github.com/zyedidia/micro/releases/download/v#{version}/micro-#{version}-linux-arm.tar.gz",
       i686: "https://github.com/zyedidia/micro/releases/download/v#{version}/micro-#{version}-linux32.tar.gz",
     x86_64: "https://github.com/zyedidia/micro/releases/download/v#{version}/micro-#{version}-linux64.tar.gz"
  })
  source_sha256({
    aarch64: '54e5bc8a786ca103ec7e3c6d81c2799e21b21660e92edfbbdaa0561a6e601797',
     armv7l: '54e5bc8a786ca103ec7e3c6d81c2799e21b21660e92edfbbdaa0561a6e601797',
       i686: 'a105dcf5407760d11dd29c6e014238c655b1db2b0c3f08eb0e83fc986fbda196',
     x86_64: 'dfa1b6ae53e4e0b063b54224fd2b6b0a3c3159ea09d042a3a8f5cd001844d44c'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'micro', "#{CREW_DEST_PREFIX}/bin/micro", mode: 0o755
  end
end
