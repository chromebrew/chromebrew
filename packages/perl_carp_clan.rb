require 'package'

class Perl_carp_clan < Package
  description 'Report errors from perspective of caller of a "clan" of modules'
  homepage 'https://metacpan.org/pod/Carp::Clan'
  version '6.08-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/E/ET/ETHER/Carp-Clan-6.08.tar.gz'
  source_sha256 'c75f92e34422cc5a65ab05d155842b701452434e9aefb649d6e2289c47ef6708'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-1_armv7l/perl_carp_clan-6.08-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-1_armv7l/perl_carp_clan-6.08-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-1_i686/perl_carp_clan-6.08-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_carp_clan/6.08-1_x86_64/perl_carp_clan-6.08-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f3ebb5e1420ae2fb02e2043326019a84515432d33510749ae0cd7e917aeee109',
     armv7l: 'f3ebb5e1420ae2fb02e2043326019a84515432d33510749ae0cd7e917aeee109',
       i686: '44a337556d4ac69e3fa7d441b748653aad1a028309b0693ab79b2db99f03eacf',
     x86_64: '295172aab40d44e24afc5a3f0dc6eed4303339b19b3b93a2366181a1e2b46b1f'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
