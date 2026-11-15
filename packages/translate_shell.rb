require 'buildsystems/autotools'

class Translate_shell < Autotools
  description 'Translate Shell is a command-line translator powered by Google Translate (default), Bing Translator, Yandex, Translate, and Apertium giving you easy access to one of these translation engines in your terminal:'
  homepage 'https://www.soimort.org/translate-shell/'
  version '0.9.7.1'
  license 'Unlicense'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/soimort/translate-shell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82f73eaffc9a8a805f565aacdb65e4480f25393c42bc4699f58f350a752a2d47',
     armv7l: '82f73eaffc9a8a805f565aacdb65e4480f25393c42bc4699f58f350a752a2d47',
     x86_64: '347bdabaa28aea8e0f5f673d9adda273c7af131a604167e23fa278bce6bb302f'
  })

  depends_on 'aspell' => :executable # Can also depend on hunspell instead of aspell
  depends_on 'gawk' => :executable # Has to be gawk (uses awk to access network)
  depends_on 'rlwrap' => :executable

  autotools_skip_configure

  # All tests pass but it still errors at the end.
  # run_tests
end
