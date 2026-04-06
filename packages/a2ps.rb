require 'buildsystems/autotools'

class A2ps < Autotools
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'https://www.gnu.org/software/a2ps/'
  version '4.15.8'
  license 'GPL-3'
  # Builds are currently broken on i686: https://savannah.gnu.org/bugs/?65903
  compatibility 'aarch64 armv7l x86_64'
  # Bootstrapping from git fails: https://savannah.gnu.org/bugs/index.php?65830
  source_url "https://ftp.gnu.org/gnu/a2ps/a2ps-#{version}.tar.gz"
  source_sha256 '87ff9d801cb11969181d5b8cf8b65e65e5b24bb0c76a1b825e8098f2906fbdf4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a81d47616093f46f1a7029817d449d6be1aec689655879207569aa38633a8beb',
     armv7l: 'a81d47616093f46f1a7029817d449d6be1aec689655879207569aa38633a8beb',
     x86_64: '2df5c44693e7692ea7e89433da2bfaf314c5a2ce2f8cadd4d61b97e76b6783f2'
  })

  depends_on 'bdwgc' => :executable
  depends_on 'glibc' => :executable
  depends_on 'libpaper' => :executable
  depends_on 'py3_pspdfutils' => :executable

  run_tests
end
