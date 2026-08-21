require 'buildsystems/perl'

class Perl_uri < PERL
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version "5.36-#{CREW_PERL_VER}"
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/URI-#{version.split('-')[0]}.tar.gz"
  source_sha256 '32719e57413db6e18492e104707b95c2210df637614c512e7368c9ec3c2f783b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c6b537384ee53563d2ee538184a559c15047bc0047ea83fe00653e92bec142f',
     armv7l: '5c6b537384ee53563d2ee538184a559c15047bc0047ea83fe00653e92bec142f',
       i686: '312db805513c81aea0b129858d8e135c11ba8219d6bf26070b5fb32c06fe9fab',
     x86_64: '6472f92cfc54899c5a15203d05c6c890b6a9628b9562fe4f5c8787c5ea7721b8'
  })

  depends_on 'perl' => :logical
end
