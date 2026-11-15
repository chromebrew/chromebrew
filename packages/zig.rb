require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.17.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://ziglang.org/download/#{version}/zig-arm-linux-#{version}.tar.xz",
     armv7l: "https://ziglang.org/download/#{version}/zig-arm-linux-#{version}.tar.xz",
       i686: "https://ziglang.org/download/#{version}/zig-x86-linux-#{version}.tar.xz",
     x86_64: "https://ziglang.org/download/#{version}/zig-x86_64-linux-#{version}.tar.xz"
  })
  source_sha256({
    aarch64: '45b5262ef4d4d1e70d21683b2ef4c1b765b067f34a13e2aa57d5f92bb02382a9',
     armv7l: '45b5262ef4d4d1e70d21683b2ef4c1b765b067f34a13e2aa57d5f92bb02382a9',
       i686: '0855367e096917bb0b628050d994d1871cc8c1f9192542163f9f93b6a30c9c6c',
     x86_64: '3581863e3cbcfd0fce0efc682ce7e9e93da96668a977791d356a26d2a7e9b17a'
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
