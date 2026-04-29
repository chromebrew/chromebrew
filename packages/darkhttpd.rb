require 'package'

class Darkhttpd < Package
  description 'Minimal webserver written by Emil Mikulic'
  homepage 'https://unix4lyfe.org/darkhttpd/'
  version '1.17'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/emikulic/darkhttpd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59fd02af9dd5e20d656d3b8e0bef55eeea072c1b9d20aaf42517842a6c78cd38',
     armv7l: '59fd02af9dd5e20d656d3b8e0bef55eeea072c1b9d20aaf42517842a6c78cd38',
       i686: '1a66fb3d85ea1771b77b3fe58421b194a5ede18b151dead9105da58cbce0bf04',
     x86_64: '1a100d14938b55db98f78001b07cc555019cb7582a77dff0106ab505a573b99b'
  })

  depends_on 'glibc' => :executable

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'darkhttpd', "#{CREW_DEST_PREFIX}/bin/darkhttpd", mode: 0o755
  end
end
