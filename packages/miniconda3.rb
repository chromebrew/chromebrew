require 'package'

class Miniconda3 < Package
  description 'Anaconda is the world\'s most popular Python data science platform.'
  homepage 'https://conda.io/miniconda.html'
  version '4.5.11'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://raw.githubusercontent.com/conda/conda/4.5.11/README.rst'
    source_sha256 '9a5d4e87325a5015bfc00167a0eb41d53e1e7a7f47f2078e50f5fb7ab3082b11'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/miniconda3-4.5.11-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/miniconda3-4.5.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: 'f42040d6e439e545bf80a372bd277e0e12370a995425b50cdfdc1fe0fb9dc491',
    x86_64: '18f8b5c8e75dc03a441358616eb17c9000425d720df45cb446bbbfe7f84c94f9',
  })

  def self.install
    case ARCH
    when 'i686'
      system 'curl -Ls -o miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86.sh'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('miniconda.sh') ) == '5dca8f7aaeeab9506f801c7c8b561a1e7e00aadc3a21008f3c72f82766f6fec6'
    when 'x86_64'
      system 'curl -Ls -o miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('miniconda.sh') ) == 'ea4594241e13a2671c5b158b3b813f0794fe58d514795fbf72a1aad24db918cf'
    end
    case ARCH
    when 'i686','x86_64'
      system "bash miniconda.sh -b -p #{CREW_PREFIX}/share/miniconda3"
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
        system "echo '#!/bin/bash' > conda"
        system "echo 'cd #{CREW_PREFIX}/share/miniconda3' >> conda"
        system "echo 'bin/conda \"\$@\"' >> conda"
        system "chmod +x conda"
      end
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
      system "cp -r #{CREW_PREFIX}/share/miniconda3 #{CREW_DEST_PREFIX}/share"
    end
  end
end
