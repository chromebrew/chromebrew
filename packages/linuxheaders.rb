require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage 'https://kernel.org/'
  version '4.14'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

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
