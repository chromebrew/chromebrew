require 'package'

class Dmd < Package
  description 'D Programming Language compiler'
  homepage 'https://dlang.org/'
  version '2.114.0'
  license 'BSL-1.0'
  compatibility 'x86_64'
  min_glibc '2.32'
  source_url "https://github.com/dlang/dmd/releases/download/v#{version}/dmd.#{version}.linux.tar.xz"
  source_sha256 '9bf481ccf099e56d2acbde45fdcab8bcad86d7e134ad1fd1faa8e00b807e13e9'

  conflicts_with 'ldc'
  depends_on 'gcc_lib' # R

  no_compile_needed

  def self.install
    Dir.chdir 'linux/bin64' do
      binaries = %w[ddemangle dmd dub dustmite rdmd]
      FileUtils.install binaries, "#{CREW_DEST_PREFIX}/bin", mode: 0o755
      FileUtils.install 'dmd.conf', "#{CREW_DEST_PREFIX}/etc/dmd.conf", mode: 0o644
    end
    Dir['linux/lib64/*'].each do |library|
      lib = File.basename(library)
      FileUtils.install library, "#{CREW_DEST_LIB_PREFIX}/#{lib}", mode: 0o644
    end
    Dir['man/man1/*'].each do |manpage|
      man = File.basename(manpage)
      FileUtils.install manpage, "#{CREW_DEST_MAN_PREFIX}/man1/#{man}", mode: 0o644
    end
    Dir['man/man5/*'].each do |manpage|
      man = File.basename(manpage)
      FileUtils.install manpage, "#{CREW_DEST_MAN_PREFIX}/man5/#{man}", mode: 0o644
    end
  end
end
