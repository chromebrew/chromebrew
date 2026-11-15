require 'buildsystems/autotools'

class Sluice < Autotools
  description 'Sluice is a program that reads input on stdin and outputs on stdout at a specified data rate.'
  homepage 'https://github.com/ColinIanKing/sluice'
  version '0.03.01'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/sluice.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8a189bf8c165714411b62080190f3ddf7885192c7bdc5ff5c56605882d5bf41',
     armv7l: 'c8a189bf8c165714411b62080190f3ddf7885192c7bdc5ff5c56605882d5bf41',
       i686: 'ad78a68b39f9d13ef84493165411e3708d83d3b107aa601ba593150ed497407a',
     x86_64: '1d9cac96774d9c7b17ee086cbf429ac8057537ecd72d4acad78f3ee18fc322ed'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  print_source_bashrc

  def self.patch
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    File.write '10-sluice', <<~EOF
      #!/bin/bash
      source #{CREW_PREFIX}/share/bash-completion/completions/sluice
    EOF
  end

  autotools_skip_configure

  autotools_install_extras do
    FileUtils.install '10-sluice', "#{CREW_DEST_PREFIX}/etc/env.d/10-sluice", mode: 0o644
  end
end
