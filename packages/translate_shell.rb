require 'package'

class Translate_shell < Package
  description 'Translate Shell is a command-line translator powered by Google Translate (default), Bing Translator, Yandex, Translate, and Apertium giving you easy access to one of these translation engines in your terminal:'
  homepage 'https://www.soimort.org/translate-shell/'
  version '0.9.6.12'
  compatibility 'all'
  source_url 'https://github.com/soimort/translate-shell/archive/v0.9.6.12.tar.gz'
  source_sha256 '4c4843a8c66276190535b8435775ecb5d9c8286083a33cdbe2db608eba93ca97'

  depends_on 'rlwrap'
  depends_on 'aspell' #Can also depend on hunspell instead of aspell

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
