require 'package'

class Glibc_headers < Package
  description 'GNU C Library Headers'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.23'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.24.tar.xz'
  source_sha256 '99d4a3e8efd144d71488e478f62587578c0f4e1fa0b4eed47ee3d4975ebeb5d3'

  depends_on 'libc6'

  def self.build
    system "crew", "download", "glibc223"
    system "tar", "-xf", "glibc223-2.23-3-chromeos-x86_64.tar.xz", "-C", "."
  end

  def self.install
    Dir.chdir ("usr/local") do
      system "cp", "-r", "include", "#{CREW_DEST_PREFIX}/"
    end
  end
end
