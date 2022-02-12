require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.9.0'
  license 'MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://ziglang.org/download/0.9.0/zig-linux-armv7a-0.9.0.tar.xz'
    source_sha256 '50225dee6e6448a63ee96383a34d9fe3bba34ae8da1a0.9.09bde2cdfc1df87d'
  when 'i686'
    source_url 'https://ziglang.org/download/0.9.0/zig-linux-i386-0.9.0.tar.xz'
    source_sha256 'b0dcf688349268c883292acdd55eaa3c13d73b9146e4b990fad95b84a2ac528b'
  when 'x86_64'
    source_url 'https://ziglang.org/download/0.9.0/zig-linux-x86_64-0.9.0.tar.xz'
    source_sha256 '5c55344a877d557fb1b28939785474eb7f4f2f327aab55293998f501f7869fa6'
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
