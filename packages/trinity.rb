require 'package'

class Trinity < Package
  description 'Linux system call fuzzer'
  homepage 'https://github.com/kernelslacker/trinity'
  version '2025.09.02'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/kernelslacker/trinity.git'
  git_hashtag '294c46522620afffd7b57af7ef743131ff55a488'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ce63cc3be86167955ef26758520b5ef261de9b042c1f2bcf33d273e49a5f0c8',
     armv7l: '6ce63cc3be86167955ef26758520b5ef261de9b042c1f2bcf33d273e49a5f0c8',
       i686: '9c73a747dedf1a7f237456fb6874270c248def64195eaccff184193109b9fcb6',
     x86_64: 'e1da6e90da9e89e303c8efe3b5e4bd4bbe3d55b120a408eb5d5847f8610a54f5'
  })

  depends_on 'glibc' # R

  def self.build
    system './configure && make'
  end

  def self.install
    system 'make', "INSTALL_PREFIX=#{CREW_DEST_PREFIX}", 'install'
    FileUtils.install 'trinity.1', "#{CREW_DEST_MAN_PREFIX}/man1/trinity.1", mode: 0o644
  end
end
