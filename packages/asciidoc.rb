require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  @_ver = '10.2.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/asciidoc/asciidoc-py3.git"
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0_armv7l/asciidoc-10.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0_armv7l/asciidoc-10.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0_i686/asciidoc-10.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0_x86_64/asciidoc-10.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4938d31371e755e03f9ae78d179099c1ef0fcb4ca419e02ba5b1203441dcf83b',
     armv7l: '4938d31371e755e03f9ae78d179099c1ef0fcb4ca419e02ba5b1203441dcf83b',
       i686: '8b1f2f327ed69d4be43cad21e52b9de5e1325fcd8d5c9ef9eaca1c23176cb8b0',
     x86_64: '6465851be648192b9aebb6c311ae427c0ba33842332bc8a25e9aaa79b3045072'
  })

  def self.prebuild
    system 'autoconf'
    system "sed -i 's,/etc/vim,#{CREW_PREFIX}/etc/vim,g' Makefile.in"
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/vim"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
