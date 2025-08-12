require 'buildsystems/autotools'

class A2ps < Autotools
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'https://www.gnu.org/software/a2ps/'
  version '4.15.7'
  license 'GPL-3'
  # Builds are currently broken on i686: https://savannah.gnu.org/bugs/?65903
  compatibility 'aarch64 armv7l x86_64'
  # Bootstrapping from git fails: https://savannah.gnu.org/bugs/index.php?65830
  source_url "https://ftpmirror.gnu.org/a2ps/a2ps-#{version}.tar.gz"
  source_sha256 'asasadas'
  # source_url 'https://git.savannah.gnu.org/git/a2ps.git'
  # git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebecfeff108d16f671271dadcb423d43f5342c2a19fd705ff18e38673de86d32',
     armv7l: 'ebecfeff108d16f671271dadcb423d43f5342c2a19fd705ff18e38673de86d32',
     x86_64: '1e7a0c86ad72bbddcbcb85e01d3d848109ddc9e5680004206a2fc5428d0e261c'
  })

  depends_on 'bdwgc'
  depends_on 'gperf' => :build
  depends_on 'gnupg' => :build
  depends_on 'libpaper'
  depends_on 'py3_pspdfutils'
  depends_on 'rsync' => :build

  run_tests

  def self.prebuild
    FileUtils.rm_rf 'gnulib'
    downloader 'https://gitweb.git.savannah.gnu.org/gitweb/?p=gnulib.git;a=snapshot;h=613ce3ecf2e83a0551c3d9d0a2cb5f6c410bd4b8;sf=tgz', 'asasasa', 'gnulib-snapshot.tgz'
    system 'tar fx gnulib-snapshot.tgz --one-top-level=gnulib --strip-components=1'
    # system './bootstrap'
    # system 'autoreconf -fiv'
  end
end
