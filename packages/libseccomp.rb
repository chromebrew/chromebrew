require 'buildsystems/autotools'

class Libseccomp < Autotools
  description 'The libseccomp library provides an easy to use, platform independent, interface to the Linux Kernel\'s syscall filtering mechanism.'
  homepage 'https://github.com/seccomp/libseccomp'
  version '2.5.5'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/seccomp/libseccomp.git'
  git_hashtag "v#{@version}"

  depends_on 'glibc' # R
  depends_on 'gperf' => :build
end
