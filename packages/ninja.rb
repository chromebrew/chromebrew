require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.10.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja/archive/v1.10.2.tar.gz'
  source_sha256 'ce35865411f0490368a8fc383f29071de6690cbadc27704734978221f25e2bed'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.10.2_armv7l/ninja-1.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.10.2_armv7l/ninja-1.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.10.2_i686/ninja-1.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.10.2_x86_64/ninja-1.10.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd6fe1cfab1c8c0c9a4865fcc1918ebe86a4effd17a28d9fc7b90401e550e2b90',
     armv7l: 'd6fe1cfab1c8c0c9a4865fcc1918ebe86a4effd17a28d9fc7b90401e550e2b90',
       i686: '36f809229fd7779f0783742a579043c9b8a69ec9454efcb1ff7655fd621d5e45',
     x86_64: '40ee7476d70e15874acb59b43e4e379c67cc65793ead2af6fbd67331f06193ff'
  })

  depends_on 're2c' => :build

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      AR=gcc-ar \
      python3 configure.py --bootstrap"
    system 'ninja'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'ninja', "#{CREW_DEST_PREFIX}/bin/ninja", mode: 0o755
  end
end
