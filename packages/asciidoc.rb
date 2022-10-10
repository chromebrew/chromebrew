require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  @_ver = '10.2.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/asciidoc/asciidoc-py3.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0_armv7l/asciidoc-10.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0_armv7l/asciidoc-10.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0_i686/asciidoc-10.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0_x86_64/asciidoc-10.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '670251a67306c395c45747f28e887bad4841122f13da2da2d63556c2c2a9c402',
     armv7l: '670251a67306c395c45747f28e887bad4841122f13da2da2d63556c2c2a9c402',
       i686: '95df915b33dc23cd27b5ad5ad0392d1e5fdb18334ba12320a6cbc6d6c772298b',
     x86_64: '06a65dadc0a722f9fcbd4d127280865595e7c36c1e9a7ca67898c17af1a2520a'
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
