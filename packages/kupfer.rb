require 'package'

class Kupfer < Package
  description 'a smart, quick launcher'
  homepage 'https://kupferlauncher.github.io/'
  version 'v321'
  license 'GPL-3.0'
  compatibility 'x86_64'
  source_url 'https://github.com/kupferlauncher/kupfer.git'
  git_hashtag version
  binary_compression 'tar.zst'

  depends_on 'desktop_file_utils'
  depends_on 'shared_mime_info'
  depends_on 'py3_dbus_python'
  depends_on 'py3_pyxdg'
  depends_on 'py3_docutils' => :build
  depends_on 'python3' => :build
  depends_on 'sommelier'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/kupfer/v321_x86_64/kupfer-v321-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '453db640d22278269b89a31f07543abba98b06bc026665314dbe26ba56b7d542'
  })

  def self.build
    system "./waf configure --prefix=#{CREW_PREFIX}"
    system "./waf -j#{CREW_NPROC}"
  end

  def self.install
    system './waf', "--destdir=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system "update-desktop-database #{CREW_PREFIX}/share/applications"
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end
end
