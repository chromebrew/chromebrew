require 'package'

class Aws < Package
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version '1.19.53'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b5c350d0e754a9d710c8fe5caff4c9b4c6f2a5327930984a71c490c4e8c29e32',
     armv7l: 'b5c350d0e754a9d710c8fe5caff4c9b4c6f2a5327930984a71c490c4e8c29e32',
       i686: '29bf3490a8df4b2e69e59c3896f34e94a062cc87be66228beedee1746ddcdcfd',
     x86_64: 'c77ef8bb2f994afa6f5eceac354ee3d18a4365bf31f26e6db0b27c8c410e66bf'
  })

  depends_on 'groff'
  depends_on 'python3' => :build

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} \
    -I awscli==#{version} --no-warn-script-location"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    @awsbashrc = <<~AWSBASHRCEOF
      # Amazon Web Services CLI bash completion
      source #{CREW_PREFIX}/bin/aws_bash_completer
    AWSBASHRCEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/aws", @awsbashrc)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/zsh.d"
    @awszshrc = <<~AWSZSHRCEOF
      # Amazon Web Services CLI zsh completion
      source #{CREW_PREFIX}/bin/aws_zsh_completer.sh
    AWSZSHRCEOF
    File.write("#{CREW_DEST_PREFIX}/etc/zsh.d/aws", @awszshrc)
  end
end
