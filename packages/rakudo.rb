require 'package'

class Rakudo < Package
  description 'Raku® (formerly Perl 6) is a language specification similar to C and C++.'
  homepage 'https://rakudo.org/'
  version '2023.12'
  license 'Artistic-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/rakudo/rakudo/releases/download/2023.12/rakudo-2023.12.tar.gz'
  source_sha256 '01a4131fb79a63a563b71a40f534d4f3db15cc71c72f8ae19f965b786e98baea'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rakudo/2023.12_armv7l/rakudo-2023.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rakudo/2023.12_armv7l/rakudo-2023.12-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rakudo/2023.12_x86_64/rakudo-2023.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '82d68d8a9c742a4dc513315298f33fc854325279249771cf6b67a1b7dd8b49b3',
     armv7l: '82d68d8a9c742a4dc513315298f33fc854325279249771cf6b67a1b7dd8b49b3',
     x86_64: '92d2ac6f683888b870f3ae6305260ea89b67155a735868de7c0e413480a18e03'
  })

  def self.build
    system "perl Configure.pl --gen-moar --gen-nqp --backends=moar --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make test'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Not sure why the following was not included in the install but it was a staged build so...
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/pkgconfig"
    FileUtils.mv "#{CREW_PREFIX}/include/moar", "#{CREW_DEST_PREFIX}/include"
    FileUtils.mv "#{CREW_PREFIX}/include/libuv", "#{CREW_DEST_PREFIX}/include"
    FileUtils.mv "#{CREW_PREFIX}/include/libtommath", "#{CREW_DEST_PREFIX}/include"
    FileUtils.mv "#{CREW_PREFIX}/include/dyncall", "#{CREW_DEST_PREFIX}/include"
    FileUtils.mv "#{CREW_PREFIX}/include/mimalloc", "#{CREW_DEST_PREFIX}/include"
    FileUtils.mv "#{CREW_PREFIX}/share/nqp", "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv "#{CREW_PREFIX}/share/pkgconfig/moar.pc", "#{CREW_DEST_PREFIX}/share/pkgconfig"
    FileUtils.install "#{CREW_PREFIX}/lib/libmoar.so", "#{CREW_DEST_LIB_PREFIX}/libmoar.so", mode: 0o644
    FileUtils.install "#{CREW_PREFIX}/bin/moar", "#{CREW_DEST_PREFIX}/bin/moar", mode: 0o755
    FileUtils.install "#{CREW_PREFIX}/bin/nqp", "#{CREW_DEST_PREFIX}/bin/nqp", mode: 0o755
    FileUtils.install "#{CREW_PREFIX}/bin/nqp-m", "#{CREW_DEST_PREFIX}/bin/nqp-m", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'rakudo -h' to get started.\n".lightblue
  end
end
