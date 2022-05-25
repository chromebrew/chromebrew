require 'package'

class Autoconf213 < Package
  description 'A GNU tool for automatically configuring source code Legacy 2.1x version'
  homepage 'https://www.gnu.org/software/autoconf/'
  version '2.13-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/autoconf/autoconf-2.13.tar.gz'
  source_sha256 'f0611136bee505811e9ca11ca7ac188ef5323a8e2ef19cffd3edb3cf08fd791e'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf213/2.13-1_armv7l/autoconf213-2.13-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf213/2.13-1_armv7l/autoconf213-2.13-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf213/2.13-1_i686/autoconf213-2.13-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf213/2.13-1_x86_64/autoconf213-2.13-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fe089c6ec2d91a455bc5cd38bd73a653e0b80728bf873d0589ed57f0c7ab04be',
     armv7l: 'fe089c6ec2d91a455bc5cd38bd73a653e0b80728bf873d0589ed57f0c7ab04be',
       i686: '1b6ba4eac9c9547458438cb4924a4640300221ed30bcad9c3765a55d35e7a744',
     x86_64: '98f744a5a7ae84583997e57ec03dcc6ce1f962b6316bd6d4c54a6c3ebaad5a36'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --infodir=#{CREW_PREFIX}/share/info \
      --program-suffix=-2.13 \
      --datadir=#{CREW_PREFIX}/share/autoconf213"
    system 'make'
  end

  def self.install
    system "make prefix=#{CREW_DEST_PREFIX} \
      infodir=#{CREW_DEST_PREFIX}/share/info \
      datadir=#{CREW_DEST_PREFIX}/share/autoconf213 \
      install"
    # Avoid conflict with autoconf package.
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/info/standards.info"
  end
end
