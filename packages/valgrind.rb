require 'buildsystems/autotools'

class Valgrind < Autotools
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'https://valgrind.org/'
  version '3.28.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/valgrind.git'
  git_hashtag "VALGRIND_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4c671e5e8acf863e4ec07869001f06a02611d3039c0a582e9e4dbfa048832d6',
     armv7l: 'a4c671e5e8acf863e4ec07869001f06a02611d3039c0a582e9e4dbfa048832d6',
       i686: 'eef2468281576c8a1e05f2960cc304918bfd5a82e499e35bdcd66de2e732ffe7',
     x86_64: '66292411929e59575dcbae4f2e193fedbd881cd6f642785e9cecf5e169c4309a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  no_lto
  case ARCH
  when 'aarch64', 'armv7l'
    arch_flags_override
  end
  autotools_configure_options (ARCH == 'x86_64' ? '--enable-only64bit' : '--enable-only32bit').to_s
end
