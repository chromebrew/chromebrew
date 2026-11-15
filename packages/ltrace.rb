require 'buildsystems/autotools'

class Ltrace < Autotools
  description 'ltrace intercepts and records dynamic library calls which are called by an executed process and the signals received by that process.'
  homepage 'https://gitlab.com/cespedes/ltrace'
  version '0.8.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/cespedes/ltrace.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ee507aa1db380e7d2ecbed3dafbba88f30c4979be7a7f16e00398810eecad61',
     armv7l: '3ee507aa1db380e7d2ecbed3dafbba88f30c4979be7a7f16e00398810eecad61',
     x86_64: 'da6d76553b71d80373fbe811db899f3769fdd0dfae9d40613cbd883f18ab8429'
  })

  depends_on 'elfutils' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libunwind' => :executable
  depends_on 'procps' => :executable
  depends_on 'xzutils' => :executable
  depends_on 'zlib' => :executable

  def self.build
    system './autogen.sh'
    # Disable selinux. It would be nice if there was a configure switch option to disable.
    system "sed -i '14831,14892d' configure"
    system "CFLAGS='-Wno-error=int-conversion -Wno-error=implicit-function-declaration -Wno-error=maybe-uninitialized' \
      ./configure #{CREW_CONFIGURE_OPTIONS} --without-elfutils #{ARCH.eql?('x86_64') ? '--enable-year2038' : '--disable-year2038'}"
    system 'make'
  end

  run_tests
end
