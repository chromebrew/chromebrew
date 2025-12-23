require 'package'

class Hyperfine < Package
  description 'A command-line benchmarking tool'
  homepage 'https://github.com/sharkdp/hyperfine'
  version '1.20.0'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/sharkdp/hyperfine/releases/download/v#{version}/hyperfine-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/sharkdp/hyperfine/releases/download/v#{version}/hyperfine-v#{version}-arm-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/sharkdp/hyperfine/releases/download/v#{version}/hyperfine-v#{version}-i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/sharkdp/hyperfine/releases/download/v#{version}/hyperfine-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'f13c6ae21380d90b03310bd74a672db579a6a45d1b5df91bf2e06baf8f1cf4fd',
     armv7l: 'f13c6ae21380d90b03310bd74a672db579a6a45d1b5df91bf2e06baf8f1cf4fd',
       i686: 'a5209e023c9396a94251614218ece32c0c0ae219fb159245d53c8cee5f9d9eeb',
     x86_64: '63ad53934062118f5b0be11785e0bb1603d4b91667d1921f2fd8df9a8712040a'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/hyperfine"
    FileUtils.mv 'hyperfine', "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'hyperfine.1', "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.mv 'autocomplete/hyperfine.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/10-hyperfine"
    FileUtils.rm_rf 'autocomplete'
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/hyperfine"
  end

  def self.postinstall
    ExitMessage.add "\nType 'hyperfine -h' to get started.\n"
  end
end
