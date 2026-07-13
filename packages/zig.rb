require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.16.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://ziglang.org/download/#{version}/zig-arm-linux-#{version}.tar.xz",
     armv7l: "https://ziglang.org/download/#{version}/zig-arm-linux-#{version}.tar.xz",
       i686: "https://ziglang.org/download/#{version}/zig-x86-linux-#{version}.tar.xz",
     x86_64: "https://ziglang.org/download/#{version}/zig-x86_64-linux-#{version}.tar.xz"
  })
  source_sha256({
    aarch64: 'f85116bf2f9189bb6ae280c7f92f03b89c2551a88e17881c0c2df86bf4e42c50',
     armv7l: 'f85116bf2f9189bb6ae280c7f92f03b89c2551a88e17881c0c2df86bf4e42c50',
       i686: '4e34e279a9f856358de420490b531974c3d37f8f3707eef9f0342e92c14c301f',
     x86_64: '70e49664a74374b48b51e6f3fdfbf437f6395d42509050588bd49abe52ba3d00'
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
