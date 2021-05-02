require 'package'

class Re2c < Package
  description 're2c is a free and open-source lexer generator for C and C++.'
  homepage 'http://re2c.org/'
  version '2.1.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/skvadrik/re2c/releases/download/2.1.1/re2c-2.1.1.tar.lz'
  source_sha256 '635860abc1c611dc5f7ab85581fa65bfa9b447946763b073d38e51620467539b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/2.1.1_armv7l/re2c-2.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/2.1.1_armv7l/re2c-2.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/2.1.1_i686/re2c-2.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/2.1.1_x86_64/re2c-2.1.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f83c472ffa93b475b4fe715cbf05e131d8f9865d516af8d45a9ef3d5f029d1fd',
     armv7l: 'f83c472ffa93b475b4fe715cbf05e131d8f9865d516af8d45a9ef3d5f029d1fd',
       i686: '8f2ce53ecda3396e3fb199955a5803fd1ac695590a838a73f80cf1ce684680d5',
     x86_64: '527b1e15f7c58f7725d04d0f025b630af76564ae42b14d979d6d958f221f92cd'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS}"
    system 'make'
    system 'make bootstrap'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
