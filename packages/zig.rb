require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.9.1'
  license 'MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://ziglang.org/download/0.9.1/zig-linux-armv7a-0.9.1.tar.xz'
    source_sha256 '6de64456cb4757a555816611ea697f86fba7681d8da3e1863fa726a417de49be'
  when 'i686'
    source_url 'https://ziglang.org/download/0.9.1/zig-linux-i386-0.9.1.tar.xz'
    source_sha256 'e776844fecd2e62fc40d94718891057a1dbca1816ff6013369e9a38c874374ca'
  when 'x86_64'
    source_url 'https://ziglang.org/download/0.9.1/zig-linux-x86_64-0.9.1.tar.xz'
    source_sha256 'be8da632c1d3273f766b69244d80669fe4f5e27798654681d77c992f17c237d7'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zig"
    FileUtils.cp_r '*', "#{CREW_DEST_PREFIX}/share/zig"
    FileUtils.ln_s "#{CREW_PREFIX}/share/zig/zig", "#{CREW_DEST_PREFIX}/bin/zig"
  end

  def self.postinstall
    puts "\nType 'zig' to get started.\n".lightblue
  end
end
