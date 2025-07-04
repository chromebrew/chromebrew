require 'buildsystems/perl'

class Perl_gtk3 < PERL
  description 'Perl interface to the 3.x series of the gtk+ toolkit'
  homepage 'https://metacpan.org/pod/Gtk3'
  version "0.038-#{CREW_PERL_VER}"
  license 'GPL 2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Gtk3-0.038.tar.gz'
  source_sha256 '70dc4bf2aa74981c79e15fd298d998e05a92eba4811f1ad5c9f1f4de37737acc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7a520f85676609ab8ccc8ae6853936ec6d759523b2882a08006ec000fe11055',
     armv7l: 'f7a520f85676609ab8ccc8ae6853936ec6d759523b2882a08006ec000fe11055',
     x86_64: '1729c89dd5edfe85624a46476de5377cd6444be918ab148af31fcd2a26527767'
  })

  depends_on 'gtk3' # R
end
