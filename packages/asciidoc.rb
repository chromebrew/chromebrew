require 'package'

class Asciidoc < Package
  description 'AsciiDoc is a presentable text document format for writing articles, UNIX man pages and other small to medium sized documents.'
  homepage 'http://asciidoc.org/'
  @_ver = '10.2.0'
  version "#{@_ver}-py3.11"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/asciidoc-py/asciidoc-py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0-py3.11_armv7l/asciidoc-10.2.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0-py3.11_armv7l/asciidoc-10.2.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0-py3.11_i686/asciidoc-10.2.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciidoc/10.2.0-py3.11_x86_64/asciidoc-10.2.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9d9e125e7e1fab3a3fa1ff82add361230733c56ac9394b66be23dbea56bc92df',
     armv7l: '9d9e125e7e1fab3a3fa1ff82add361230733c56ac9394b66be23dbea56bc92df',
       i686: '32d5524581b246d450dcd5c0f2bc63f708c7d4e0f7940bbbcb8b959308b7d83a',
     x86_64: '0eff5eaa8d1bda4c2c8b5a841a4e28c47d5a4af569d7917207539039d7f36ac8'
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
