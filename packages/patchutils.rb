require 'buildsystems/autotools'

class Patchutils < Autotools
  description 'Patchutils is a small collection of programs that operate on patch files.'
  homepage 'http://cyberelk.net/tim/software/patchutils/'
  version '0.4.5'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://cyberelk.net/tim/data/patchutils/stable/patchutils-#{version}.tar.xz"
  source_sha256 '8386a35a4d2d3cbc28fdcc93c5be007c382c78e3ee079070139f0d822e013325'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '030809998a2de25d0afd81e69b2d6e80172a1c1e9940c2540c1e01d640c0fd67',
     armv7l: '030809998a2de25d0afd81e69b2d6e80172a1c1e9940c2540c1e01d640c0fd67',
       i686: '03c0619a5790aea4991abe69f3c6581f2e51078d639be7599cefe502aab301cc',
     x86_64: '2f6c36e9c6d61fba2452a61fa7c148f698bf1a46038392a1dd6764c92c5fea90'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'pcre2' => :executable

  run_tests

  autotools_install_extras do
    # Remove conflict with bash_completion.
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/bash-completion/completions/interdiff"
    %w[gitdiff gitdiffview gitshow gitshowview patchview-wrapper svndiff svndiffview].each do |bin|
      system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,' #{CREW_DEST_PREFIX}/bin/#{bin}"
    end
  end
end
