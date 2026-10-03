require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.17.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://ziglang.org/download/#{version}/zig-arm-linux-#{version}.tar.xz",
     armv7l: "https://ziglang.org/download/#{version}/zig-arm-linux-#{version}.tar.xz",
       i686: "https://ziglang.org/download/#{version}/zig-x86-linux-#{version}.tar.xz",
     x86_64: "https://ziglang.org/download/#{version}/zig-x86_64-linux-#{version}.tar.xz"
  })
  source_sha256({
    aarch64: '53f0045cdef7ba06da70a12b2ef654e4c5283b0139bc441aa7d84f364b46de43',
     armv7l: '53f0045cdef7ba06da70a12b2ef654e4c5283b0139bc441aa7d84f364b46de43',
       i686: '55e39e175cd5b3098afc29ec47b2590134f5b874175369fb9ae7b8e836d7531a',
     x86_64: '1cbe9df9f27e6b78d14ccbca43b6703a404ef79ef1c463de901d7f088d4e2026'
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
