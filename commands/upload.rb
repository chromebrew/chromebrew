require 'uri'
require 'digest/sha2'
require 'net/http'
require_relative '../lib/color'
require_relative '../lib/const'

class Command
  def self.upload(pkg)
    # Fetch the GITLAB_TOKEN environment variable and set it to gitlab_token, aborting if it is not set.
    gitlab_token = ENV.fetch('GITLAB_TOKEN') { abort 'GITLAB_TOKEN environment variable not set.'.lightred }

    # If the package has the no_zstd property, the binaries will be compressed as .tar.xz
    # Otherwise, the binaries will be compressed as .tar.zst
    binary_compression = pkg.no_zstd? ? 'tar.xz' : 'tar.zst'

    # Get the name of the compressed binary.
    pkg_tarfile = "#{pkg.name}-#{pkg.version}-chromeos-#{ARCH}.#{binary_compression}"
    # Get the absolute path to the compressed binary, aborting if there is no file there.
    abort "No compiled binary found for #{pkg.name}.".lightred unless File.file?(pkg_tarfile_path = File.join(CREW_LOCAL_BUILD_DIR, pkg_tarfile))

    # For now, support deploy tokens and personal access tokens.
    token_label = gitlab_token.split('-').first == 'glpat' ? 'PRIVATE-TOKEN' : 'DEPLOY-TOKEN'

    # Upload the new file, exiting early if we failed so no changes are made to the package file.
    uri = URI("https://gitlab.com/api/v4/projects/26210301/packages/generic/#{pkg.name}/#{pkg.version}_#{ARCH}/#{pkg_tarfile}")
    # This can be implemented much more cleanly once the Net::HTTP.put method is available.
    # https://github.com/ruby/net-http/pull/175
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    response = https.put(uri, File.read(pkg_tarfile_path), { token_label => gitlab_token })

    # Any response that isn't Net::HTTPSuccess means that something has failed, so we abort.
    abort "Received error code #{response.code} and message #{response.message} when trying to upload #{pkg.name}.".lightred unless response.code_type.superclass == Net::HTTPSuccess

    # Get the path to the package file.
    pkg_file = File.join(CREW_LOCAL_REPO_ROOT, 'packages', "#{pkg.name}.rb")

    # Read the package file into memory.
    file = File.read(pkg_file)

    # Update the package file with the new binary_compression value.
    puts "Updating binary_compression in #{pkg_file}..."
    file.sub!(/binary_compression.*/, "binary_compression '#{binary_compression}'")

    # Update the package file with the new binary_sha256 value.
    puts "Updating binary_sha256 in #{pkg_file}..."
    file.gsub!(pkg.binary_sha256[ARCH.to_sym], Digest::SHA256.hexdigest(File.read(pkg_tarfile_path)))

    # Write our changes to the package file.
    File.write(pkg_file, file)

    # Add the changed manifest to the git index.
    system "git -C #{CREW_LOCAL_REPO_ROOT} add manifest/#{ARCH}/#{pkg.name[0]}/#{pkg.name}.filelist"
  end
end
