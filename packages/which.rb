require 'buildsystems/autotools'

class Which < Autotools
  description 'which shows the full path of (shell) commands.'
  homepage 'https://carlowood.github.io/which/'
  version '2.23'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/which/which-#{version}.tar.gz"
  source_sha256 'b620507312c5e97566a3c6cfaf99144fefc18a0da7d941401dfa0f5f58fb0368'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9f4fc79e47e571c519d63eae22687527028403907f6bc4d2912abe41f96fb2e',
     armv7l: 'c9f4fc79e47e571c519d63eae22687527028403907f6bc4d2912abe41f96fb2e',
       i686: '32deff126b05a282e441171b7a36dbe2de582eb4376ea5496dcbc82e579268f3',
     x86_64: '53d4d8200ed6215ef4eca4ee0ab0b72bd23743046023218b2835971dbf9de30e'
  })
end
