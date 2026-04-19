require 'buildsystems/autotools'

class Groff < Autotools
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.24.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/groff.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9e70902dd906532b725da59ed259d50dd84b4420bf1b8d7a8fd463d37fdc64b',
     armv7l: 'b9e70902dd906532b725da59ed259d50dd84b4420bf1b8d7a8fd463d37fdc64b',
       i686: 'eedb9cc8a8e07e47cda56b5a70891a43402b4116915db04a2ef007ba77d3a06e',
     x86_64: '00b78896e838583d62491f0114aa6ae4aae163c0f53510193eb7bbb78c8b6a64'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'netpbm' => :build
  depends_on 'uchardet' => :executable

  autotools_configure_options '--without-x'

  def self.patch
    # See https://lists.gnu.org/archive/html/groff/2024-11/msg00149.html
    File.write '.tarball-version', <<~EOF
      #{version}
    EOF
  end
end
