require 'package'

class Libglibc < Package
  description 'GNU C Library Libraries' # :/D
  homepage 'https://www.gnu.org/software/libc/'
  version '2.23'
  source_url 'https://github.com/skycocker/chromebrew/files/2059646/bashrc.txt'
  source_sha256 '17346974f26e49b1261fb35ef51261fbcc9043844f63eb736ec3c2f2e0453ec2'

  def self.build
    system "crew", "download", "glibc223"
    system "tar", "-xf", "#{CREW_BREW_DIR}/glibc223-2.23-3-chromeos-x86_64.tar.xz", "-C", "."
  end

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}"
    Dir.chdir ("usr/local") do
      system "mv etc/ .."
      system "rm $(find . | fgrep .so)"
      system "mv ../etc/ ."
    end
  end
end
