require 'package'

class Translate_shell < Package
  description 'Translate Shell is a command-line translator powered by Google Translate (default), Bing Translator, Yandex, Translate, and Apertium giving you easy access to one of these translation engines in your terminal:'
  homepage 'https://www.soimort.org/translate-shell/'
  version '0.9.6.12'
  license 'Unlicense'
  compatibility 'all'
  source_url 'https://github.com/soimort/translate-shell/archive/v0.9.6.12.tar.gz'
  source_sha256 '4c4843a8c66276190535b8435775ecb5d9c8286083a33cdbe2db608eba93ca97'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'bc872006b0244ca14597766b9a7c0ef5d432cd3502dedc2d3f541c214b20c131',
     armv7l: 'bc872006b0244ca14597766b9a7c0ef5d432cd3502dedc2d3f541c214b20c131',
       i686: 'e463ba1532762b85555ca82326b460d36e25e8f99cc7943baa40fdf02217a627',
     x86_64: '200047abf2945d2df10815ed1469f22020f00fe93d16ea8dd279e36795cc78d8'
  })

  depends_on 'rlwrap'
  depends_on 'gawk'   # Has to be gawk (uses awk to access network)
  depends_on 'aspell' # Can also depend on hunspell instead of aspell

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
