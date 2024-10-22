require 'package'

class Vlock < Package
  description 'Lock one or more sessions on the Linux console.'
  homepage 'https://repo.or.cz/vlock'
  version '2.2.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://repo.or.cz/vlock.git'
  git_hashtag "vlock-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2cce6ad44532dec07254e7872e0af94afc54b52609e59acbf6af759954f52b9a',
     armv7l: '2cce6ad44532dec07254e7872e0af94afc54b52609e59acbf6af759954f52b9a',
       i686: '1d969bcda1614db08cbb688cd09418926e327712394bef8e35ebd39885c0fead',
     x86_64: '2c72acb141eb6f5d2c87d02b1faae534a8e1ab6cf68eae3ca2207a00b4d118e9'
  })

  depends_on 'glibc' # R
  depends_on 'linux_pam' # R

  def self.patch
    system "sed -i 's,root -g \$(ROOT_GROUP),#{USER} -g #{USER},g' Makefile"
    system "sed -i 's,root -g \$(MODULE_GROUP),#{USER} -g #{USER},g' modules/Makefile"
    system "sed -i 's,root -g \$(SCRIPT_GROUP),#{USER} -g #{USER},g' scripts/Makefile"
  end

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --enable-shadow"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
