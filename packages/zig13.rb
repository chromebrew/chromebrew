require 'package'

class Zig13 < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.13.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://ziglang.org/download/#{version}/zig-linux-armv7a-#{version}.tar.xz",
     armv7l: "https://ziglang.org/download/#{version}/zig-linux-armv7a-#{version}.tar.xz",
       i686: "https://ziglang.org/download/#{version}/zig-linux-x86-#{version}.tar.xz",
     x86_64: "https://ziglang.org/download/#{version}/zig-linux-x86_64-#{version}.tar.xz"
  })
  source_sha256({
    aarch64: '4b0550239c2cd884cc03ddeb2b9934708f4b073ad59a96fccbfe09f7e4f54233',
     armv7l: '4b0550239c2cd884cc03ddeb2b9934708f4b073ad59a96fccbfe09f7e4f54233',
       i686: '876159cc1e15efb571e61843b39a2327f8925951d48b9a7a03048c36f72180f7',
     x86_64: 'd45312e61ebcc48032b77bc4cf7fd6915c11fa16e4aad116b66c9468211230ea'
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
