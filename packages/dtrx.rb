require 'package'

class Dtrx < Package
  description "An intelligent archive extraction tool for UNIX-like systems standing for 'Do The Right Extraction.'"
  homepage 'https://brettcsmith.org/2007/dtrx/' # 404 Not Found
  version '7.1'
  license '' # Can't find license for project
  compatibility 'all'
  source_url 'https://brettcsmith.org/2007/dtrx/dtrx-7.1.tar.gz' # 404 Not Found
  source_sha256 '1c9afe48e9d9d4a1caa4c9b0c50593c6fe427942716ce717d81bae7f8425ce97'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dtrx/7.1_armv7l/dtrx-7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dtrx/7.1_armv7l/dtrx-7.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dtrx/7.1_i686/dtrx-7.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dtrx/7.1_x86_64/dtrx-7.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a607b05853dfa122ebdb852f28ac59b6142c99f7ee156a631b75bc5d82f797fa',
     armv7l: 'a607b05853dfa122ebdb852f28ac59b6142c99f7ee156a631b75bc5d82f797fa',
       i686: 'cdd735f6be940b2535b89226bfdeba5b65e92cbdfe0a828bceb7fc5787d872d7',
     x86_64: '4817af93d2c30c4ced5c8fb5a4e0ebc7ebb51fb6fbfb2300380b27221b6b5c49'
  })

  depends_on 'binutils'
  depends_on 'bzip2'
  depends_on 'cabextract'
  depends_on 'cpio'
  depends_on 'lha'
  depends_on 'python2'
  depends_on 'unrar'
  depends_on 'unshield'
  depends_on 'unzip'

  def self.install
    system "python setup.py install --prefix=#{CREW_PREFIX}"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp #{CREW_PREFIX}/bin/dtrx #{CREW_DEST_PREFIX}/bin"
  end
end
