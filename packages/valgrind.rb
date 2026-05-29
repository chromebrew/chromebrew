require 'buildsystems/autotools'

class Valgrind < Autotools
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'https://valgrind.org/'
  version '3.27.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/valgrind.git'
  git_hashtag "VALGRIND_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b250a6172f0e7af2b3ec7e2d65aa4d2d217fdc132182d27e32640f4ca633e66',
     armv7l: '4b250a6172f0e7af2b3ec7e2d65aa4d2d217fdc132182d27e32640f4ca633e66',
       i686: '4bca2baca3b9a1c1458646d8288c400b398a86a17e6ee9b4e5e8517c81c32904',
     x86_64: 'f12e9c38280dec3017364e8716fa70f8963dde013c10e0aa912de5437d77eda6'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  no_lto
  case ARCH
  when 'aarch64', 'armv7l'
    arch_flags_override
  end
  autotools_configure_options (ARCH == 'x86_64' ? '--enable-only64bit' : '--enable-only32bit').to_s
end
