require 'package'

class Libseccomp < Package
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.5.4'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/seccomp/libseccomp/archive/v#{version}.tar.gz"
  source_sha256 '96bbadb4384716272a6d2be82801dc564f7aab345febfe9b698b70fc606e3f75'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libseccomp/2.5.4_armv7l/libseccomp-2.5.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libseccomp/2.5.4_armv7l/libseccomp-2.5.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libseccomp/2.5.4_i686/libseccomp-2.5.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libseccomp/2.5.4_x86_64/libseccomp-2.5.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd4aafa04c27719b2d5d5be94a89846d0a118710effd5f1144e2139a0b8f9c09d',
     armv7l: 'd4aafa04c27719b2d5d5be94a89846d0a118710effd5f1144e2139a0b8f9c09d',
       i686: '96743fd080af70581781c4e0b17bdb3f5c91b765c1355803193527984176f5f9',
     x86_64: '1097b0549a2f0210fa15ca54f7916b9927363534913dbc3030270c39c2559d3d'
  })

  depends_on 'glibc' # R
  depends_on 'gperf' => :build

  def self.build
    system './autogen.sh'
    system "./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
