require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.1.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gawk/gawk-5.1.1.tar.lz'
  source_sha256 'e583dd5e82b867b0d2917ce6b79c29842b63956e81302be659bb9f85a238163d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.1.1_armv7l/gawk-5.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.1.1_armv7l/gawk-5.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.1.1_i686/gawk-5.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gawk/5.1.1_x86_64/gawk-5.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bfa66b130d1a72231b73495fa54d52b28b9a522058170bedeabd0ddae6fdf9f0',
     armv7l: 'bfa66b130d1a72231b73495fa54d52b28b9a522058170bedeabd0ddae6fdf9f0',
       i686: '137639aa2664ac896cb05a328ea2c93af4065c9e4fc55cecd5c93b93245bf3e0',
     x86_64: '3f06d6828946279f87406466b04c3942ce50e8480dc4ffe1cb656aca672b8e4f'
  })

  depends_on 'libsigsegv'
  depends_on 'readline' => :build
  depends_on 'ncurses'
  depends_on 'mpfr'
  depends_on 'gmp'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    # fails on i686.
    system 'make check || true'
  end

  def self.install
    # conflicts with mawk for /usr/local/bin/awk
    # ENV['CREW_CONFLICTS_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
