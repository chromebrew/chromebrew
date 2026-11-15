require 'buildsystems/autotools'

class Pdfgrep < Autotools
  description 'a commandline utility to search text in PDF files'
  homepage 'https://pdfgrep.org/'
  version '2.2.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pdfgrep.org/download/pdfgrep-#{version}.tar.gz"
  source_sha256 '0661e531e4c0ef097959aa1c9773796585db39c72c84a02ff87d2c3637c620cb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd472d3a763b753ab1e38f56e2548c22d0a81c9e58976f176207845d5663a3ca0',
     armv7l: 'd472d3a763b753ab1e38f56e2548c22d0a81c9e58976f176207845d5663a3ca0',
     x86_64: 'bcf191088d06e146b07859b42c4cb4fda4e2beca15ec4b503ef3441abc00cb22'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libgcrypt' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'poppler' => :executable

  print_source_bashrc

  autotools_build_extras do
    File.write '10-pdfgrep', <<~EOF
      #!/bin/bash
      source #{CREW_PREFIX}/share/bash-completion/completions/pdfgrep
    EOF
  end

  autotools_install_extras do
    FileUtils.install '10-pdfgrep', "#{CREW_DEST_PREFIX}/etc/env.d/10-pdfgrep", mode: 0o644
  end
end
