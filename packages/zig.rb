require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.14.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://ziglang.org/download/#{version}/zig-armv7a-linux-#{version}.tar.xz",
     armv7l: "https://ziglang.org/download/#{version}/zig-armv7a-linux-#{version}.tar.xz",
       i686: "https://ziglang.org/download/#{version}/zig-x86-linux-#{version}.tar.xz",
     x86_64: "https://ziglang.org/download/#{version}/zig-x86_64-linux-#{version}.tar.xz"
  })
  source_sha256({
    aarch64: '1b34d9ecfaeb3b360e86c0bc233e1a8a2bbed2d40f2d4f20c12bde2128714324',
     armv7l: '1b34d9ecfaeb3b360e86c0bc233e1a8a2bbed2d40f2d4f20c12bde2128714324',
       i686: '4bce6347fa112247443cb0952c19e560d1f90b910506cf895fd07a7b8d1c4a76',
     x86_64: '24aeeec8af16c381934a6cd7d95c807a8cb2cf7df9fa40d359aa884195c4716c'
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
