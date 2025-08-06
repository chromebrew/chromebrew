require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.14.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://ziglang.org/download/#{version}/zig-linux-armv7a-#{version}.tar.xz",
     armv7l: "https://ziglang.org/download/#{version}/zig-linux-armv7a-#{version}.tar.xz",
       i686: "https://ziglang.org/download/#{version}/zig-x86-linux-#{version}.tar.xz",
     x86_64: "https://ziglang.org/download/#{version}/zig-linux-x86_64-#{version}.tar.xz"
  })
  source_sha256({
    aarch64: 'a67dbfa9bdf769228ec994f2098698c619f930883ca5ef638f50eee2d7788d10',
     armv7l: 'a67dbfa9bdf769228ec994f2098698c619f930883ca5ef638f50eee2d7788d10',
       i686: '55d1ba21de5109686ffa675b9cc1dd66930093c202995a637ce3e397816e4c08',
     x86_64: '473ec26806133cf4d1918caf1a410f8403a13d979726a9045b421b685031a982'
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
