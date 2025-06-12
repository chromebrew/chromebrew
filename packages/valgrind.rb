require 'buildsystems/autotools'

class Valgrind < Autotools
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'https://valgrind.org/'
  version '3.25.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/valgrind.git'
  git_hashtag "VALGRIND_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '13b0b51890c99c7432f4520d382b646fa95e6122da22ff8d3980486104c35226',
     armv7l: '13b0b51890c99c7432f4520d382b646fa95e6122da22ff8d3980486104c35226',
       i686: '6e7ba98fb4ec8d26f24d3af4cd2ea6fe49e9e46d5c99906ecea59c00a93436fd',
     x86_64: 'd31ec469f3cd72f73d05e2b41a629275bdf24542e4944b5eb846b404419fa5ac'
  })

  depends_on 'glibc' # R
  no_lto
  case ARCH
  when 'aarch64', 'armv7l'
    arch_flags_override
  end
  autotools_configure_options (ARCH == 'x86_64' ? '--enable-only64bit' : '--enable-only32bit').to_s
end
