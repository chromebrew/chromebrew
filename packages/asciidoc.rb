require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  @_ver = '10.2.0'
  version "#{@_ver}-py3.12"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/asciidoc-py/asciidoc-py.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0-py3.12_armv7l/asciidoc-10.2.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0-py3.12_armv7l/asciidoc-10.2.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0-py3.12_i686/asciidoc-10.2.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0-py3.12_x86_64/asciidoc-10.2.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '71b9fc4de0279a23adec68f88be4ef8df3bd02169b3a3396950926b429f9042a',
     armv7l: '71b9fc4de0279a23adec68f88be4ef8df3bd02169b3a3396950926b429f9042a',
       i686: 'cf2d072e56e52e07db5e796291b40cfcc8e7f545700a8c521792c9df468ee46f',
     x86_64: '86d9dd8aa8b03b603649321ad5ca4e7dde3d4afc49900aa995f9e4458574d2a4'
  })

  depends_on 'python3'

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
