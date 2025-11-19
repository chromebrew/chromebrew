require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.15.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://ziglang.org/download/#{version}/zig-arm-linux-#{version}.tar.xz",
     armv7l: "https://ziglang.org/download/#{version}/zig-arm-linux-#{version}.tar.xz",
       i686: "https://ziglang.org/download/#{version}/zig-x86-linux-#{version}.tar.xz",
     x86_64: "https://ziglang.org/download/#{version}/zig-x86_64-linux-#{version}.tar.xz"
  })
  source_sha256({
    aarch64: '7d8401495065dae45d6249c68d5faf10508f8203c86362ccb698aeaafc66b7cd',
     armv7l: '7d8401495065dae45d6249c68d5faf10508f8203c86362ccb698aeaafc66b7cd',
       i686: '4c6e23f39daa305e274197bfdff0d56ffd1750fc1de226ae10505c0eff52d7a5',
     x86_64: '02aa270f183da276e5b5920b1dac44a63f1a49e55050ebde3aecc9eb82f93239'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zig"
    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/zig"
    FileUtils.ln_s "#{CREW_PREFIX}/share/zig/zig", "#{CREW_DEST_PREFIX}/bin/zig"
  end

  def self.postinstall
    ExitMessage.add "\nType 'zig' to get started.\n"
  end
end
