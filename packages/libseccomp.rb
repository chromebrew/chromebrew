require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  @_ver = '2.5.1'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/seccomp/libseccomp/archive/v#{@_ver}.tar.gz"
  source_sha256 '76ad54e31d143b39a99083564045212a965e026a1010a742edd793d26d699829'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libseccomp-2.5.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a5fb74e92c03f02a6079796234e0c3c192ec689d71bc5b5dd104c0decdd747b1',
     armv7l: 'a5fb74e92c03f02a6079796234e0c3c192ec689d71bc5b5dd104c0decdd747b1',
       i686: '4d9b966795112a9bf8a6d3da564345998ee007400c9720b4d86b58e79c7c65ea',
     x86_64: 'dc052c6c4962cc1f5b30c1a73f0ab397abd15406d808a18f96ed8ff095a62e25'
  })

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
