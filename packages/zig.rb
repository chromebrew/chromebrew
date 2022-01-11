require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.8.1'
  license 'MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://ziglang.org/download/0.8.1/zig-linux-armv7a-0.8.1.tar.xz'
    source_sha256 '5ba58141805e2519f38cf8e715933cbf059f4f3dade92c71838cce341045de05'
  when 'i686'
    source_url 'https://ziglang.org/download/0.8.1/zig-linux-i386-0.8.1.tar.xz'
    source_sha256 '2f3e84f30492b5f1c5f97cecc0166f07a8a8d50c5f85dbb3a6ef2a4ee6f915e6'
  when 'x86_64'
    source_url 'https://ziglang.org/download/0.8.1/zig-linux-x86_64-0.8.1.tar.xz'
    source_sha256 '6c032fc61b5d77a3f3cf781730fa549f8f059ffdb3b3f6ad1c2994d2b2d87983'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zig"
    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/zig"
    FileUtils.ln_s "#{CREW_PREFIX}/share/zig/zig", "#{CREW_DEST_PREFIX}/bin/zig"
  end

  def self.postinstall
    puts "\nType 'zig' to get started.\n".lightblue
  end
end
