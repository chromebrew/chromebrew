require 'buildsystems/perl'

class Perl_wakeonlan < PERL
  description 'Perl script for waking up computers via Wake-On-LAN magic packets'
  homepage 'https://github.com/jpoliv/wakeonlan'
  version "0.50-#{CREW_PERL_VER}"
  license 'Artistic License 2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/jpoliv/wakeonlan.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c74bf440977266afe098d481d830bfc6731ad638ef1b6216a77fdd5611c5309',
     armv7l: '3c74bf440977266afe098d481d830bfc6731ad638ef1b6216a77fdd5611c5309',
     x86_64: '5428967664500dee9f7bbce923be8a223262f555e8ae3ba527de3cfd8c33e55f'
  })

  depends_on 'perl' => :logical
end
