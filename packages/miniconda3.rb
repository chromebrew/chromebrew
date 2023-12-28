require 'package'

class Miniconda3 < Package
  description 'Anaconda is the world\'s most popular Python data science platform.'
  homepage 'https://conda.io/miniconda.html'
  version '4.5.11'
  license 'BSD-3'
  compatibility 'i686,x86_64'
  source_url 'https://raw.githubusercontent.com/conda/conda/4.5.11/README.rst'
  source_sha256 '9a5d4e87325a5015bfc00167a0eb41d53e1e7a7f47f2078e50f5fb7ab3082b11'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miniconda3/4.5.11_i686/miniconda3-4.5.11-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/miniconda3/4.5.11_x86_64/miniconda3-4.5.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: 'f42040d6e439e545bf80a372bd277e0e12370a995425b50cdfdc1fe0fb9dc491',
    x86_64: '18f8b5c8e75dc03a441358616eb17c9000425d720df45cb446bbbfe7f84c94f9'
  })

  def self.install
    case ARCH
    when 'i686'
      system 'curl -Ls -o miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86.sh'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('miniconda.sh')) == '5dca8f7aaeeab9506f801c7c8b561a1e7e00aadc3a21008f3c72f82766f6fec6'
    when 'x86_64'
      system 'curl -Ls -o miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('miniconda.sh')) == 'ea4594241e13a2671c5b158b3b813f0794fe58d514795fbf72a1aad24db918cf'
    end

    system "bash miniconda.sh -b -p #{CREW_PREFIX}/share/miniconda3"
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share]

    File.write "#{CREW_DEST_PREFIX}/bin/conda", <<~EOF, perm: 0o755
      #!/bin/bash
      cd #{CREW_PREFIX}/share/miniconda3
      bin/conda "$@"
    EOF

    FileUtils.cp "#{CREW_PREFIX}/share/miniconda3", "#{CREW_DEST_PREFIX}/share"
  end
end
