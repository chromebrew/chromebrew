require 'package'

class Libseccomp < Package
  description 'Libseccomp provides an easy-to-use, platform-independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.4.2'
  source_url 'https://github.com/seccomp/libseccomp/archive/v2.4.2.tar.gz'
  source_sha256 'c988dc3f6c641e12c68285afb57d69361f3bfd5b7235d067b3991bf9a57cca7e'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
