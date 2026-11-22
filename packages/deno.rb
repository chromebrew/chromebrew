require 'package'

class Deno < Package
  description 'A secure runtime for JavaScript and TypeScript'
  homepage 'https://deno.land'
  version '2.9.8'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://dl.deno.land/release/v#{version}/deno-x86_64-unknown-linux-gnu.zip"
  source_sha256 'a39762429792913fe762ef0b59c9cba41dbd38195984da99221a193b13d97b40'

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'zip' => :executable

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.install 'deno', "#{CREW_DEST_PREFIX}/bin/deno", mode: 0o755
    system "#{CREW_DEST_PREFIX}/bin/deno completions > 10-deno"
    FileUtils.install '10-deno', "#{CREW_DEST_PREFIX}/etc/env.d/10-deno", mode: 0o644
  end
end
