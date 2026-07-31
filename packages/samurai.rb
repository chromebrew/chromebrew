require 'buildsystems/autotools'

class Samurai < Autotools
  description 'Samurai is a ninja compatible build tool written in C.'
  homepage 'https://github.com/michaelforney/samurai/'
  version '1.3'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/michaelforney/samurai.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '784aed466b5f55b5f5ebe4f30ac3f0d2988fb3ccc4bdaecf7d63bf19bc2400c2',
     armv7l: '784aed466b5f55b5f5ebe4f30ac3f0d2988fb3ccc4bdaecf7d63bf19bc2400c2',
       i686: '225f294eeb5763d264213e3d96c3891418b0a6aa8ec327ddfcd379e2e0f8a450',
     x86_64: 'b06bc0918e3d16ed85c4bec818dc8613e8116eaab5d92b4ff4df127148552473'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.patch
    system "sed -i 's:PREFIX=/usr/local:PREFIX=#{CREW_PREFIX}:' Makefile"
    system "sed -i 's:MANDIR=\$(PREFIX)/share/man:MANDIR=#{CREW_MAN_PREFIX}:g' Makefile"
  end

  autotools_skip_configure
  autotools_make_options "CFLAGS='#{CREW_COMMON_FLAGS}' LDFLAGS='#{CREW_LINKER_FLAGS}'"
end
