
require 'package'

class Perl_locale_gettext < Package
  description 'Locale::gettext - message handling functions'
  homepage 'https://metacpan.org/pod/Locale::gettext'
  compatibility 'all'
  version '1.07'
  source_url 'https://cpan.metacpan.org/authors/id/P/PV/PVANDRY/gettext-1.07.tar.gz'
  source_sha256 '909d47954697e7c04218f972915b787bd1244d75e3bd01620bc167d5bbc49c15'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_gettext-1.07-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_gettext-1.07-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_gettext-1.07-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_locale_gettext-1.07-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '39aad2115541343c8dd71cfaae94b3d000101b5674b8deff6a0b5be74c3d8382',
     armv7l: '39aad2115541343c8dd71cfaae94b3d000101b5674b8deff6a0b5be74c3d8382',
       i686: '577de273943d0f5f4991989c3d677bae5bfbe0af87b4ddaa3d969ce11fc683dc',
     x86_64: '034808aee7e907baa2cd7d46c9892cd12e1f6be4932444ee272575e527d6176e',
  })

  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', "build", '--self-contained', '.'

    # install lib
    libdir = `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    system "mkdir -p #{CREW_DEST_DIR}#{libdir}"
    system "(cd build/lib/perl5; tar cf - .) | (cd #{CREW_DEST_DIR}#{libdir}; tar xfp -)"

    # install man
    mandir = "#{CREW_PREFIX}/share/man"
    system "mkdir -p #{CREW_DEST_DIR}#{mandir}"
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_DIR}#{mandir}; tar xfp -)"
  end

  def self.check
  end
end
