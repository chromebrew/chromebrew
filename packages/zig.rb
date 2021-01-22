require 'package'

class Zig < Package
  description 'Programming language designed for robustness, optimality, and clarity'
  homepage 'https://ziglang.org/'
  version '0.7.1'
  compatibility 'x86_64 aarch64'
  source_url 'https://ziglang.org/download/0.7.1/zig-0.7.1.tar.xz'
  source_sha256 '2db3b944ab368d955b48743d9f7c963b8f96de1a441ba5a35e197237cc6dae44'

 def self.build
   Dir.mkdir 'build'
   FileUtils.cd('build') do
     system "cmake #{CREW_CMAKE_OPTIONS} .."
     system 'make'
   end
 end
 def self.install
   FileUtils.cd('build') do
     system "DESTDIR=#{CREW_DEST_DIR} make install"
   end
  end
end
