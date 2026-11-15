# Adapted from Arch Linux po4a PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/po4a/trunk/PKGBUILD

require 'package'

class Po4a < Package
  description 'Tools for helping translation of documentation'
  homepage 'https://po4a.org/'
  version '0.74'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/mquinson/po4a.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '353ac15184be32a81095eaa406bf5dc81402bc2800c726e8f1ce960a45832289',
     armv7l: '353ac15184be32a81095eaa406bf5dc81402bc2800c726e8f1ce960a45832289',
       i686: '27b232458a5340dfd1bfdfc6e81d93127ffa3ee0bf9c142b21f4d0f7a5cf34c3',
     x86_64: '6127387076f884c0d0d50709fa6c8d73c27c055c91f987813fa65aa8f0721de3'
  })

  depends_on 'gettext' => :build
  depends_on 'libxslt' => :build
  depends_on 'perl' => :logical
  depends_on 'perl_locale_gettext' => :build
  depends_on 'perl_module_build' => :build
  depends_on 'perl_pod_parser' => :build
  depends_on 'perl_sgmls' => :build
  depends_on 'perl_term_readkey' => :build
  depends_on 'perl_text_wrapi18n' => :build
  depends_on 'perl_unicode_linebreak' => :build
  depends_on 'perl_yaml_tiny' => :build

  def self.build
    system 'perl Build.PL installdirs=vendor create_packlist=0'
    system 'LC_ALL=en_US.UTF-8 perl Build'
  end

  def self.install
    system "perl Build destdir=#{CREW_DEST_DIR} install"
    system "find #{CREW_DEST_DIR} -name .packlist -o -name perllocal.pod -delete"
  end
end
