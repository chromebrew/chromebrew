require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage 'https://kernel.org/'
  version '4.14'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/linuxheaders-4.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/linuxheaders-4.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/linuxheaders-3.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/linuxheaders-4.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4960ced072202049c4f90350ebfa6b13a3fe6750ae8a1f0d79c63ad976b66391',
     armv7l: '4960ced072202049c4f90350ebfa6b13a3fe6750ae8a1f0d79c63ad976b66391',
       i686: 'df0178926e599e8a6bb54a74c7c7cda734751e007a2bbb2e59f17a8fb3d4489f',
     x86_64: '1cbc54cf8c1af9996039c5aec487ed3f047c9c870341b08418c0d93fb40233a0',
  })

  depends_on 'linux_sources' => :build

  def self.install
    linux_src_dir = CREW_PREFIX + '/src/linux'
    Dir.chdir(linux_src_dir) do
      system 'make',
             'headers_install',
             "INSTALL_HDR_PATH=#{CREW_DEST_PREFIX}"
    end
    Dir.chdir(CREW_DEST_PREFIX + '/include') do
      system "for file in \$(find . -not -type d -name '.*'); do
                rm \${file};
              done"
    end
  end
end
