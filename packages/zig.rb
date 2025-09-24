require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.15.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://ziglang.org/download/#{version}/zig-armv7a-linux-#{version}.tar.xz",
     armv7l: "https://ziglang.org/download/#{version}/zig-armv7a-linux-#{version}.tar.xz",
       i686: "https://ziglang.org/download/#{version}/zig-x86-linux-#{version}.tar.xz",
     x86_64: "https://ziglang.org/download/#{version}/zig-x86_64-linux-#{version}.tar.xz"
  })
  source_sha256({
    aarch64: '8351c0267c2cd7866ff04c04261f06cd75af9a7130aac848ca43fd047404e229',
     armv7l: '8351c0267c2cd7866ff04c04261f06cd75af9a7130aac848ca43fd047404e229',
       i686: 'dff166f25fdd06e8341d831a71211b5ba7411463a6b264bdefa8868438690b6a',
     x86_64: 'c61c5da6edeea14ca51ecd5e4520c6f4189ef5250383db33d01848293bfafe05'
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
