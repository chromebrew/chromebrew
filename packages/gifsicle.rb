require 'package'

class Gifsicle < Package
  description 'Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations.'
  homepage 'http://www.lcdf.org/gifsicle/'
  version '1.89'
  license 'GPL-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/kohler/gifsicle/archive/v1.89.tar.gz'
  source_sha256 '9b19ff8d50d88af5a5151eaf9e62beb1dd5b72002e7b7cc3aec9b385780e6b83'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gifsicle/1.89_armv7l/gifsicle-1.89-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gifsicle/1.89_armv7l/gifsicle-1.89-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gifsicle/1.89_i686/gifsicle-1.89-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gifsicle/1.89_x86_64/gifsicle-1.89-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6cbb8a84e03b8446d26d94341d166917ae50919a6148d2ce2da54e103ebf6310',
     armv7l: '6cbb8a84e03b8446d26d94341d166917ae50919a6148d2ce2da54e103ebf6310',
       i686: '5e6e15e3ff4093e5b287ceecd60f170cf32275761aa60f706977a746eb58f3a3',
     x86_64: 'fd897442df51c04763921fbcba22143079eab0e6127ee2c031103f93768c755a'
  })

  def self.build
    system './bootstrap.sh'
    system './configure --without-x --disable-gifview'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
