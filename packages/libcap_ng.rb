require 'package'

class Libcap_ng < Package
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng'
  version '0.8.4-5d3aea2-py3.11'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/stevegrubb/libcap-ng.git'
  git_hashtag '5d3aea2d098ea222fb35a0be75adeed40e2e96d3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '151e957f7f2e69fc7522ff1b38147ba8972f3bce7a9faa0aa6feb8c059010c76',
     armv7l: '151e957f7f2e69fc7522ff1b38147ba8972f3bce7a9faa0aa6feb8c059010c76',
       i686: '04d91c8a9be68946b357e6c6970bc9b253888a09bcd285c1d98ffe28a3e4cfd7',
     x86_64: '3c7a9b520cf2d63fa5722229e44f86287bd0081d18d0561009ef1cb771783857'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' utils/captest.c"
  end

  def self.build
    system './autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} \
      --with-capability_header=#{CREW_PREFIX}/include/linux/capability.h"
    system 'make'
  end

  def self.check
    # Doesn't work if kernel doesn't match headers.
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
