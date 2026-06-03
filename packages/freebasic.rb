require 'package'

class Freebasic < Package
  description 'FreeBASIC is a free and open source, BASIC compiler for Microsoft Windows, DOS and Linux.'
  homepage 'https://www.freebasic.net/'
  # Releases appear to be misnumbered for the arm version.
  version '1.10.1'
  license 'LGPL-2 and GPL-2'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://sourceforge.net/projects/fbc/files/FreeBASIC-1.10.1/Binaries-Linux/FreeBASIC-1.10.2-debian12-armhf.tar.xz'
    source_sha256 '753c82544212744948d7e28f16c7eca8e23cfc7e0ef6fec2d567b5cdf0cbcc92'
  when 'i686'
    source_url "https://downloads.sourceforge.net/project/fbc/FreeBASIC-#{version}/Binaries-Linux/FreeBASIC-#{version}-linux-x86.tar.xz"
    source_sha256 'ff811caa5a25f5e6eba02dac42f0d01a8ea6d07d2c678fb71c56c1d2f5c2a4f3'
  when 'x86_64'
    source_url "https://downloads.sourceforge.net/project/fbc/FreeBASIC-#{version}/Binaries-Linux/FreeBASIC-#{version}-linux-x86_64.tar.xz"
    source_sha256 '8a3e82f5e07664ef47932733358257a2c70e4c16279c844a6080b48e2da256b1'
  end

  depends_on 'libtinfo'

  def self.patch
    system "sed -i 's,\$prefix/lib/freebasic,\$prefix/lib64/freebasic,g' install.sh" if ARCH.eql?('x86_64')
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    system "./install.sh -i #{CREW_DEST_PREFIX}"
    FileUtils.mv "#{CREW_DEST_PREFIX}/man", "#{CREW_DEST_PREFIX}/share"
  end

  def self.postinstall
    ExitMessage.add "\nType 'fbc' to get started.\n"
  end
end
